
/*
 * At some point, ipxe folk decided to lower timeout values
 * for the dhcp proxy stage of dhcp init quite a bit. This
 * makes some sense, since it can greatly speed up the
 * situation where a dhcp server exist, but the proxy
 * server does not response and the intend is to continue
 * through to boot from disk anyway. However, for rackhd
 * case:
 *  1) that's not our use case (we either don't response to
 *     dhcp at all OR we do want to use the proxy feature)
 *  2) The hooks to allow specialized profiles introduce a
 *     1 second delay when there is nothing there that
 *     wants to use the hook (the normal case, by far)
 *  3) If you throw in slightly complex switch setup (MLAG
 *     with native vlan, as an example), that stabilization
 *     time can introduce a little more delay.
 * In this unlucky situation, 2 and 3 conspire to make the
 * first ipxe (monorail.ipxe) that goes out just barely, but
 * fairly consistently, miss the 4 second window the code
 * is cranked down to by default. Bummer.
 *
 * So, these defines push these back to the PXE spec defaults.
 * You can look at the real src/config/dhcp.h for comments about 
 * each of these and what they mean.
 */
#undef DHCP_DISC_PROXY_TIMEOUT_SEC
#undef DHCP_REQ_PROXY_TIMEOUT_SEC
#undef PXEBS_MAX_TIMEOUT_SEC
#define DHCP_DISC_PROXY_TIMEOUT_SEC    11      /* as per PXE spec */
#define DHCP_REQ_PROXY_TIMEOUT_SEC     7       /* as per PXE spec */
#define PXEBS_MAX_TIMEOUT_SEC          7       /* as per PXE spec */

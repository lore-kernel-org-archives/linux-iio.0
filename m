Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CCEEC0
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771172640; cv=none; b=svu8IJvtfg7678jStJnhYGAL/4CzjR3oMe/LhuYb4bNxiR6bgjiOlRVfa5i3DpJaUzM9219Sn+gyH+nv+/UDqJcdqCySAaT3ftJ0n56SBp/a9fHxIqFa6dNFEiJXWpMDV/0osvtQN3rFeLxtg1max7DlbgcBQsg4AHdc+HXuhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771172640; c=relaxed/simple;
	bh=gfFic8FDzabkDj4pM+qQK4edYi78i+Nyzj81+lRNcjo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O4pqXVkr3g1FJgMKyWiNws+sy0gOF2fx74IHbzlXwM7mp+2GHtJMY1YBHYC+CzKnDQxYo/U4vDToLF7w9TtuVZQ9BOvCd0l4QWFkc3BaTXgV1eCgsZACxM3ssoiEBz+PRb2GSxcpVKpTOFmQ3a8Ushf5ESG9m6iZfi5jpizo/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNjsROM6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNjsROM6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2BE9C2BC86
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771172639;
	bh=gfFic8FDzabkDj4pM+qQK4edYi78i+Nyzj81+lRNcjo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pNjsROM62l0K4YSpTwmSsBLDX5pGLHCYgOBhyEb910kyXO/qlyx7/Q2xLuWQE0hvk
	 zNItAmhGoobGAefPXwvyYay48UM5i8O70b/ypltMywvipDraMobr9qfe7leyMsocfl
	 mNz9L/HSGVtVHNxxg9Jj+MEpBpBi2rFNjNhOM0uGkzps24dR2nJnvqpt3yOTqota4n
	 E2jlvL47XQq7w+g+AB/Mc6ZbmahATrwiYYwpevFa0X4IcVle/cIDpZ6Sq1O1QnLmZy
	 bUVQL/IBYx+yKHHwMMsJMp1qoC/nijPgmHw6kIK8Aw3mq6v8C3a65UJ2RnmG1jqJPg
	 lt4gsH/sFMn9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D73D6CAB780; Sun, 15 Feb 2026 16:23:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] [iio] [hid-sensor-rotation] Memory corruption due to
 alignment mismatch in scan buffer
Date: Sun, 15 Feb 2026 16:23:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221077-217253-sVVPIPv2cu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221077-217253@https.bugzilla.kernel.org/>
References: <bug-221077-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221077

--- Comment #3 from Jonathan Cameron (jic23@kernel.org) ---
On Sat, 14 Feb 2026 14:29:19 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/14/26 1:24 PM, Jonathan Cameron wrote:
> > On Wed, 11 Feb 2026 05:12:36 +0000
> > bugzilla-daemon@kernel.org wrote:
> >=20=20=20
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D221077
> >>
> >>             Bug ID: 221077
> >>            Summary: [iio] [hid-sensor-rotation] Memory corruption due =
to
> >>                     alignment mismatch in scan buffer
> >>            Product: Drivers
> >>            Version: 2.5
> >>           Hardware: All
> >>                 OS: Linux
> >>             Status: NEW
> >>           Severity: normal
> >>           Priority: P3
> >>          Component: IIO
> >>           Assignee: drivers_iio@kernel-bugs.kernel.org
> >>           Reporter: lixu.zhang@intel.com
> >>         Regression: Yes
> >>            Bisected b31a74075cb4ca2bb202a2e17d133ef3c9ee891f
> >>          commit-id:
> >>
> >> ### Problem
> >> In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_dec=
ml`
> and
> >> `scale_post_decml` fields in `struct dev_rot_state` get corrupted after
> the
> >> first read from the device. This issue results in invalid scale values
> being
> >> reported to userspace.
> >>
> >> ### Root Cause Analysis
> >> The issue is caused by a size mismatch between what the IIO core expec=
ts
> for
> >> the scan buffer and the actual size of the driver's scan structure.
> >>
> >> 1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consist=
s of
> a
> >> quaternion (4 * s32 =3D 16 bytes) and a timestamp (8 bytes).
> >>     ```c
> >>     struct {
> >>             s32 sampled_vals[4];
> >>             aligned_s64 timestamp;
> >>     } scan;
> >>     ```
> >>     Without explicit alignment, this structure is packed to **24 bytes=
**.=20=20
> >=20
> > I agree it's 24 bytes, but worth being clear it has explicit alignment =
to 8
> > bytes. Without that on some platforms it would be 4 byte aligned only.
> >=20=20=20
> >>
> >> 2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function
> calculates
> >> the buffer size required. It aligns the total size to the size of the
> *largest
> >> element* in the scan.
> >>     - The quaternion channel is treated as a single 16-byte element.
> >>     - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24,
> 16) =3D
> >> 32 bytes`.=20=20
> >=20
> > Ah. That is indeed a corner case and the ABI is IIRC not well documented
> > around that, let alone what we do in the kernel. We probably need to
> tighten that
> > up as well as fixing this. What userspace were you using to test this?=
=20=20
>=20
> I didn't even know we had IIO_MOD_QUATERNION as a special data type until
> Francesco's recent patches. :-o

It's not common.  Was interestingly something that looked likely to be so
in relatively early IMUs but then faded away -> probably because the algori=
thms
to get a good estimate are complex and best done on the host CPU or somewhe=
re
off sensor.

>=20
> >=20
> >=20=20=20
> >>
> >> 3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is cal=
led:
> >>     - It assumes a 32-byte buffer.
> >>     - It writes the timestamp at the end of the aligned buffer (offset
> 24).
> >>     - Since the driver allocated only 24 bytes for `scan`, the write at
> offset
> >> 24 overwrites the adjacent `scale_pre_decml` field in `struct
> dev_rot_state`.
> >>
> >> ### Evidence (Ftrace)
> >> I verified this by tracing the return values of `iio_storage_bytes_for=
_si`
> and
> >> `iio_compute_scan_bytes` using kretprobes:
> >>
> >> ```log
> >> $ cat /sys/kernel/tracing/trace_pipe
> >> r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
> >> iio_storage_bytes_for_si) arg1=3D0x10
> >> r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
> >> iio_storage_bytes_for_si) arg1=3D0x8
> >> r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
> >> iio_compute_scan_bytes) arg1=3D0x20
> >> ```
> >>
> >> The trace confirms:
> >> - Largest element =3D 16 bytes.
> >> - Total raw size =3D 16 (quat) + 8 (ts) =3D 24 bytes.
> >> - Final aligned size =3D ALIGN(24, 16) =3D 32 bytes.
> >>
> >> The memory layout mismatch is:
> >> - IIO Core needs: 32 bytes
> >> - Driver struct has: 24 bytes
> >>
> >> ### Regression
> >> This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
> >> hid-sensor-rotation: remove unnecessary alignment")`, which removed the
> >> `__aligned(16)` attribute that previously ensured the struct was padde=
d to
> 32
> >> bytes.
> >>
> >> ### Proposed Fix
> >> Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state`=
 has
> the
> >> correct padding to match the IIO core's expectations.
> >>
> >> ```c
> >> struct {
> >>         s32 sampled_vals[4] __aligned(16);=20=20
> > Agreed that fix is correct.
> > However, we definitely also need to add some documentation on why it is
> there.
> >=20
> > It's not actually an alignment force on sampled_vals, but rather on the
> timestamp.
> > We can't just mark the timestamp as then it will have two aligned marki=
ngs
> on x86_32.
> >=20
> > David, given we both missed this when 'tidying' this up wrongly what do=
 you
> think
> > would make this clearest?=20=20
>=20
> I think it would make sense to have an IIO_DECLARE_REPEAT_ELEMENT()
> similar to IIO_DECLARE_BUFFER_WITH_TS().

It will be worth checking if we have more than one user.  When quaternion's
turn up there are always other channels.  The oddity is that sometimes the
fusion
algorithms used produce the data at a different rate to the underlying chan=
nel
types (or like in HID's case) don't tell you what that relationship is, data
just
shows up tagged with what type it is and we split it to the different IIO
devices.

As such they at least sometimes share a buffer with non repeated channels.
>=20
> #define IIO_DECLARE_REPEAT_ELEMENT(type, name, count) \
>       type name[count] __aligned(sizeof(type) * count)
>=20
> And it would be used like:
>=20
> struct {
>       IIO_DECLARE_REPEAT_ELEMENT(s32, sampled_vals, 4);
>       aligned_s64 timestamp;

Isn't our timestamp ending up in the wrong place anyway vs that
definition (and the original one pre bug)? There is a lazy hack in
iio_push_to_buffers_with_ts() that assumes the structure is 8 byte aligned =
:(
and puts the timestamp in the last 8 bytes but per normal channel packing e=
ach
element is naturally aligned so it should be buffer + 16, not buffer + 32 -=
 8

We still need the extra padding the aligned is bringing because the kfifo w=
hen
the configuration matches this layout has 32 byte entries, but the timestamp
should be where it this structure says it is not where it's currently going.

Given how common that iio_push_to_buffers_with_timestamp()/ts() is
(and fiddly computing the timestamp position is) I'd suggest in this case we
open code iio_push_to_buffers_with_ts().  We can swing by after this bug is
fixed and try to work out if there is a cleaner solution (probably compute =
as
part of the demux setup and stash it for reuse).

+ Change to _ts() version as it would have screamed about this without the
corruption see by the reporter as the buffer would have been smaller than t=
he
kfifo was expecting.

This is a userspace ABI bug fix / change. So we need to know what userspace=
 is
making
use of quaternion channels and fix it as well.

Jonathan


> } scan;
>=20
> >=20
> >=20
> > Thanks for reporting this with such a thorough and detailed investigati=
on!
> > Makes our lives a lot easier.=20=20
>=20
> Should I spin up a fix?
>=20
If you have time to take on also landing the timestamp in the right place t=
hen
that would be great. I'm a touch snowed under for the next week or two.

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

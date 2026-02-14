Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C025F994
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771100967; cv=none; b=byYkuFaQBtYrBv24+TzvvkDNVLVDOxBb/wCUcoY6sxxF4aa8b5vpHAiL+V1811ZtSorKaGmmASp3FWBG1TwWOsQJemaD6Xpw3JaSH7yf9oWn+jXrpo5prtQy23/51Fuxi68WHmIWjiMP4o10ktW0soerrCFI2NMa4P5ZFYWE3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771100967; c=relaxed/simple;
	bh=4JmJICHcJfg67FFc+GrcyZryRA63VC64SsSfvanPh44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hble9KOf0DHpNn5+JjPBEVvtKgnBAo/JEqZfPV1f4Ot3zU3Q6AH60n1WgUZenXAe0srUw6XQHdoP9Jj1JpyxNWAl5hdOvMO4DqSB1Ho4yAjLnxMLyk9Bc7CJcUgmfUvgqSG0IaiFLP/OpM8XI6PuK9YATQBxI+xM2sSYk7Vh5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reTe2QyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reTe2QyA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26A3C19425
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771100966;
	bh=4JmJICHcJfg67FFc+GrcyZryRA63VC64SsSfvanPh44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=reTe2QyAfFEFFzN324WbtcjENt1xTHsmhDknt7udjIFtrhcdeISNtFug6srzlHnWA
	 bRJLolDNzc0JnQrhC1o7lHBJHNPK8saA2pHvOefT0g2e4bSoVWv+VIPOO/wOSMKSg5
	 qG0h/g517ArHmldzTW1ruQX4rXHebRcjOTKQy+jB3lsEhH8IS/szku401fsvY0dykd
	 h9c1TiSXGgbbYwWJZTqcjHrycH6L2Keb+bG+G6UUOq3iO2NSQCsa2D6PIlHAN75Gd0
	 zgN/HEf6h22GfVVH6wZQEGMpRAzraaFc4r1YeW80IctUppq4Gx81T/lxWOgRWNzHTX
	 33MGvNjWYqU+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97860C53BC7; Sat, 14 Feb 2026 20:29:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] [iio] [hid-sensor-rotation] Memory corruption due to
 alignment mismatch in scan buffer
Date: Sat, 14 Feb 2026 20:29:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dlechner@baylibre.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221077-217253-PAP7pA6Gyy@https.bugzilla.kernel.org/>
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

--- Comment #2 from dlechner@baylibre.com ---
On 2/14/26 1:24 PM, Jonathan Cameron wrote:
> On Wed, 11 Feb 2026 05:12:36 +0000
> bugzilla-daemon@kernel.org wrote:
>=20
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D221077
>>
>>             Bug ID: 221077
>>            Summary: [iio] [hid-sensor-rotation] Memory corruption due to
>>                     alignment mismatch in scan buffer
>>            Product: Drivers
>>            Version: 2.5
>>           Hardware: All
>>                 OS: Linux
>>             Status: NEW
>>           Severity: normal
>>           Priority: P3
>>          Component: IIO
>>           Assignee: drivers_iio@kernel-bugs.kernel.org
>>           Reporter: lixu.zhang@intel.com
>>         Regression: Yes
>>            Bisected b31a74075cb4ca2bb202a2e17d133ef3c9ee891f
>>          commit-id:
>>
>> ### Problem
>> In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_decml`
>> and
>> `scale_post_decml` fields in `struct dev_rot_state` get corrupted after =
the
>> first read from the device. This issue results in invalid scale values b=
eing
>> reported to userspace.
>>
>> ### Root Cause Analysis
>> The issue is caused by a size mismatch between what the IIO core expects=
 for
>> the scan buffer and the actual size of the driver's scan structure.
>>
>> 1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consists =
of a
>> quaternion (4 * s32 =3D 16 bytes) and a timestamp (8 bytes).
>>     ```c
>>     struct {
>>             s32 sampled_vals[4];
>>             aligned_s64 timestamp;
>>     } scan;
>>     ```
>>     Without explicit alignment, this structure is packed to **24 bytes**.
>=20
> I agree it's 24 bytes, but worth being clear it has explicit alignment to=
 8
> bytes. Without that on some platforms it would be 4 byte aligned only.
>=20
>>
>> 2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function
>> calculates
>> the buffer size required. It aligns the total size to the size of the
>> *largest
>> element* in the scan.
>>     - The quaternion channel is treated as a single 16-byte element.
>>     - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24, =
16)
>>     =3D
>> 32 bytes`.
>=20
> Ah. That is indeed a corner case and the ABI is IIRC not well documented
> around that, let alone what we do in the kernel. We probably need to tigh=
ten
> that
> up as well as fixing this. What userspace were you using to test this?

I didn't even know we had IIO_MOD_QUATERNION as a special data type until
Francesco's recent patches. :-o

>=20
>=20
>>
>> 3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is calle=
d:
>>     - It assumes a 32-byte buffer.
>>     - It writes the timestamp at the end of the aligned buffer (offset 2=
4).
>>     - Since the driver allocated only 24 bytes for `scan`, the write at
>>     offset
>> 24 overwrites the adjacent `scale_pre_decml` field in `struct
>> dev_rot_state`.
>>
>> ### Evidence (Ftrace)
>> I verified this by tracing the return values of `iio_storage_bytes_for_s=
i`
>> and
>> `iio_compute_scan_bytes` using kretprobes:
>>
>> ```log
>> $ cat /sys/kernel/tracing/trace_pipe
>> r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
>> iio_storage_bytes_for_si) arg1=3D0x10
>> r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
>> iio_storage_bytes_for_si) arg1=3D0x8
>> r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
>> iio_compute_scan_bytes) arg1=3D0x20
>> ```
>>
>> The trace confirms:
>> - Largest element =3D 16 bytes.
>> - Total raw size =3D 16 (quat) + 8 (ts) =3D 24 bytes.
>> - Final aligned size =3D ALIGN(24, 16) =3D 32 bytes.
>>
>> The memory layout mismatch is:
>> - IIO Core needs: 32 bytes
>> - Driver struct has: 24 bytes
>>
>> ### Regression
>> This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
>> hid-sensor-rotation: remove unnecessary alignment")`, which removed the
>> `__aligned(16)` attribute that previously ensured the struct was padded =
to
>> 32
>> bytes.
>>
>> ### Proposed Fix
>> Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state` h=
as
>> the
>> correct padding to match the IIO core's expectations.
>>
>> ```c
>> struct {
>>         s32 sampled_vals[4] __aligned(16);
> Agreed that fix is correct.
> However, we definitely also need to add some documentation on why it is
> there.
>=20
> It's not actually an alignment force on sampled_vals, but rather on the
> timestamp.
> We can't just mark the timestamp as then it will have two aligned marking=
s on
> x86_32.
>=20
> David, given we both missed this when 'tidying' this up wrongly what do y=
ou
> think
> would make this clearest?

I think it would make sense to have an IIO_DECLARE_REPEAT_ELEMENT()
similar to IIO_DECLARE_BUFFER_WITH_TS().

#define IIO_DECLARE_REPEAT_ELEMENT(type, name, count) \
        type name[count] __aligned(sizeof(type) * count)

And it would be used like:

struct {
        IIO_DECLARE_REPEAT_ELEMENT(s32, sampled_vals, 4);
        aligned_s64 timestamp;
} scan;

>=20
>=20
> Thanks for reporting this with such a thorough and detailed investigation!
> Makes our lives a lot easier.

Should I spin up a fix?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

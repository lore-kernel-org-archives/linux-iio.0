Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26270EEC0
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771172639; cv=none; b=bES/gvTcyJNsRj0YS8CrXK6/7BmAHzrWhUgJ+gAn+kZBrPxswvrv/cV/CAYjruW9dD+RhYyeMIE/qGXOEUB/vhZt3qqoKx7NkKOQskOLZrzpmU6WKipIzM4l7dDGShkHOVOQbzk/vL2H5F1WdYNvPYK4wr3y+oxMNBU4K1yMu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771172639; c=relaxed/simple;
	bh=yXoJp5j4URnzEf/KbOPPN7PMzoqLlTQ27YxPXB7yWH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRttzADOvP3yO2S7tOrxvn4Wsyu45LxYl8+98WJQQMbpJ89d2MnVvUJUDbEZZ7H4aRHb6WKQMn5AQWlmz2gSFon+AjekqrWTMhK+Ib3TyUvs+gwPJeLFJtu8fBa1YqHkCzf/pwE6A8FitsH+92iK7F0sX+VV9QJ9L+D2gAcew+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU1po8Xg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU1po8Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3132AC4CEF7;
	Sun, 15 Feb 2026 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771172638;
	bh=yXoJp5j4URnzEf/KbOPPN7PMzoqLlTQ27YxPXB7yWH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YU1po8XgUZ/C5FodDefNWQ9KASVEPfXPyvc037sORR13ZV1b51r5Nm7tITCcKSBMT
	 lsXobk72qhZTwOnnjPuMIHkyphdz9DujiuiBQSCL0Bshfk0chkVnGIxuSSPXavseTt
	 V9dIhAdSI8Y1ADuwpi7RZVBPfpafEyhhkl4h4EQAAbg8xYyzIeCUUPrIPzVTPLbEa7
	 ewZa10A9Ugxn8zirOQDhdOFygKswDVRqx0RD9P0vmTd08oDk69IrwXyIEsVXr5KYAw
	 K/QtZDVNbz6pKIuPOjf7co/4ZrP30vdA0yxtChhD0Jg3e7uu4dAPeygQ2UEHKUV1Xg
	 PFmcjUEcu0gyA==
Date: Sun, 15 Feb 2026 16:23:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: bugzilla-daemon@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [Bug 221077] New: [iio] [hid-sensor-rotation] Memory corruption
 due to alignment mismatch in scan buffer
Message-ID: <20260215162351.79f40b32@jic23-huawei>
In-Reply-To: <b24cc218-1bb5-4272-8e44-054a983ec558@baylibre.com>
References: <bug-221077-217253@https.bugzilla.kernel.org/>
	<20260214192404.1240b351@jic23-huawei>
	<b24cc218-1bb5-4272-8e44-054a983ec558@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 14:29:19 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/14/26 1:24 PM, Jonathan Cameron wrote:
> > On Wed, 11 Feb 2026 05:12:36 +0000
> > bugzilla-daemon@kernel.org wrote:
> >   
> >> https://bugzilla.kernel.org/show_bug.cgi?id=221077
> >>
> >>             Bug ID: 221077
> >>            Summary: [iio] [hid-sensor-rotation] Memory corruption due to
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
> >> In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_decml` and
> >> `scale_post_decml` fields in `struct dev_rot_state` get corrupted after the
> >> first read from the device. This issue results in invalid scale values being
> >> reported to userspace.
> >>
> >> ### Root Cause Analysis
> >> The issue is caused by a size mismatch between what the IIO core expects for
> >> the scan buffer and the actual size of the driver's scan structure.
> >>
> >> 1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consists of a
> >> quaternion (4 * s32 = 16 bytes) and a timestamp (8 bytes).
> >>     ```c
> >>     struct {
> >>             s32 sampled_vals[4];
> >>             aligned_s64 timestamp;
> >>     } scan;
> >>     ```
> >>     Without explicit alignment, this structure is packed to **24 bytes**.  
> > 
> > I agree it's 24 bytes, but worth being clear it has explicit alignment to 8
> > bytes. Without that on some platforms it would be 4 byte aligned only.
> >   
> >>
> >> 2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function calculates
> >> the buffer size required. It aligns the total size to the size of the *largest
> >> element* in the scan.
> >>     - The quaternion channel is treated as a single 16-byte element.
> >>     - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24, 16) =
> >> 32 bytes`.  
> > 
> > Ah. That is indeed a corner case and the ABI is IIRC not well documented
> > around that, let alone what we do in the kernel. We probably need to tighten that
> > up as well as fixing this. What userspace were you using to test this?  
> 
> I didn't even know we had IIO_MOD_QUATERNION as a special data type until
> Francesco's recent patches. :-o

It's not common.  Was interestingly something that looked likely to be so
in relatively early IMUs but then faded away -> probably because the algorithms
to get a good estimate are complex and best done on the host CPU or somewhere
off sensor.

> 
> > 
> >   
> >>
> >> 3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is called:
> >>     - It assumes a 32-byte buffer.
> >>     - It writes the timestamp at the end of the aligned buffer (offset 24).
> >>     - Since the driver allocated only 24 bytes for `scan`, the write at offset
> >> 24 overwrites the adjacent `scale_pre_decml` field in `struct dev_rot_state`.
> >>
> >> ### Evidence (Ftrace)
> >> I verified this by tracing the return values of `iio_storage_bytes_for_si` and
> >> `iio_compute_scan_bytes` using kretprobes:
> >>
> >> ```log
> >> $ cat /sys/kernel/tracing/trace_pipe
> >> r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
> >> iio_storage_bytes_for_si) arg1=0x10
> >> r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
> >> iio_storage_bytes_for_si) arg1=0x8
> >> r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
> >> iio_compute_scan_bytes) arg1=0x20
> >> ```
> >>
> >> The trace confirms:
> >> - Largest element = 16 bytes.
> >> - Total raw size = 16 (quat) + 8 (ts) = 24 bytes.
> >> - Final aligned size = ALIGN(24, 16) = 32 bytes.
> >>
> >> The memory layout mismatch is:
> >> - IIO Core needs: 32 bytes
> >> - Driver struct has: 24 bytes
> >>
> >> ### Regression
> >> This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
> >> hid-sensor-rotation: remove unnecessary alignment")`, which removed the
> >> `__aligned(16)` attribute that previously ensured the struct was padded to 32
> >> bytes.
> >>
> >> ### Proposed Fix
> >> Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state` has the
> >> correct padding to match the IIO core's expectations.
> >>
> >> ```c
> >> struct {
> >>         s32 sampled_vals[4] __aligned(16);  
> > Agreed that fix is correct.
> > However, we definitely also need to add some documentation on why it is there.
> > 
> > It's not actually an alignment force on sampled_vals, but rather on the timestamp.
> > We can't just mark the timestamp as then it will have two aligned markings on x86_32.
> > 
> > David, given we both missed this when 'tidying' this up wrongly what do you think
> > would make this clearest?  
> 
> I think it would make sense to have an IIO_DECLARE_REPEAT_ELEMENT()
> similar to IIO_DECLARE_BUFFER_WITH_TS().

It will be worth checking if we have more than one user.  When quaternion's
turn up there are always other channels.  The oddity is that sometimes the fusion
algorithms used produce the data at a different rate to the underlying channel
types (or like in HID's case) don't tell you what that relationship is, data just
shows up tagged with what type it is and we split it to the different IIO devices.

As such they at least sometimes share a buffer with non repeated channels.
> 
> #define IIO_DECLARE_REPEAT_ELEMENT(type, name, count) \
> 	type name[count] __aligned(sizeof(type) * count)
> 
> And it would be used like:
> 
> struct {
> 	IIO_DECLARE_REPEAT_ELEMENT(s32, sampled_vals, 4);
> 	aligned_s64 timestamp;

Isn't our timestamp ending up in the wrong place anyway vs that
definition (and the original one pre bug)? There is a lazy hack in
iio_push_to_buffers_with_ts() that assumes the structure is 8 byte aligned :(
and puts the timestamp in the last 8 bytes but per normal channel packing each
element is naturally aligned so it should be buffer + 16, not buffer + 32 - 8

We still need the extra padding the aligned is bringing because the kfifo when
the configuration matches this layout has 32 byte entries, but the timestamp
should be where it this structure says it is not where it's currently going.

Given how common that iio_push_to_buffers_with_timestamp()/ts() is
(and fiddly computing the timestamp position is) I'd suggest in this case we
open code iio_push_to_buffers_with_ts().  We can swing by after this bug is
fixed and try to work out if there is a cleaner solution (probably compute as
part of the demux setup and stash it for reuse).

+ Change to _ts() version as it would have screamed about this without the
corruption see by the reporter as the buffer would have been smaller than the
kfifo was expecting.

This is a userspace ABI bug fix / change. So we need to know what userspace is making
use of quaternion channels and fix it as well.

Jonathan
 

> } scan;
> 
> > 
> > 
> > Thanks for reporting this with such a thorough and detailed investigation!
> > Makes our lives a lot easier.  
> 
> Should I spin up a fix?
> 
If you have time to take on also landing the timestamp in the right place then
that would be great. I'm a touch snowed under for the next week or two.

Jonathan



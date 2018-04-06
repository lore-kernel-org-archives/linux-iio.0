Return-Path: <SRS0=t8Kp=G3=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 6 Apr 2018 16:15:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Martin Kelly <mkelly@xevo.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps
Message-ID: <20180406161509.0000254a@huawei.com>
In-Reply-To: <6041491c-811a-8b43-96cf-b19336332ec4@xevo.com>
References: <20180328174029.1045-1-mkelly@xevo.com>
	<20180330113606.1eba6011@archlinux>
	<6041491c-811a-8b43-96cf-b19336332ec4@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2 Apr 2018 10:07:57 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> On 03/30/2018 03:36 AM, Jonathan Cameron wrote:
> > On Wed, 28 Mar 2018 10:40:29 -0700
> > Martin Kelly <mkelly@xevo.com> wrote:
> >   
> >> When interrupts are generated at a slower rate than the FIFO fills up,
> >> we will have fewer timestamps than samples. Currently, we fill in 0 for
> >> any unmatched timestamps. However, this is very confusing for userspace,
> >> which does not expect discontinuities in timestamps and must somehow
> >> work around the issue.
> >>
> >> Improve the situation by interpolating timestamps when we can't map them
> >> 1:1 to data. We do this by assuming the timestamps we have are the most
> >> recent and interpolating backwards to fill the older data. This makes
> >> sense because inv_mpu6050_read_fifo gets called right after an interrupt
> >> is generated, presumably when a datum was generated, so the most recent
> >> timestamp matches up with the most recent datum. In addition, this
> >> assumption is borne out by observation, which shows monotonically
> >> increasing timestamps when interpolating this way but discontinuities
> >> when interpolating in the other direction.
> >>
> >> Although this method is not perfectly accurate, it is probably the best
> >> we can do if we don't get one interrupt per datum.  
> > This patch worries me somewhat - we are basically guessing what the cause
> > of the missed interrupts was.  If for example the fifo read itself
> > takes a long time, the interrupt time we have is actually valid for
> > the first sample and we should in interpolating forwards in time.
> >   
> 
> I agree with you that if the delay is somewhere after the IRQ fires but 
> prior to the FIFO read (or the FIFO read itself), then we'd need forward 
> interpolation. That said, if there is more than 1 sample in FIFO when 
> the IRQ fires, we need backwards interpolation (since those samples were 
> certainly created prior to the IRQ firing and the timestamp being 
> generated). I believe the current patch is will accurately handle the 
> backwards interpolation case but be wrong for the forwards interpolation 
> case (though it will at least guarantee samples to be monotonically 
> increasing, as they should be).
> 
> I thought about this and I think we can fix both issues. I propose we do 
> the following:
> 
> - When the IRQ fires, immediately timestamp as we already do. Also, 
> immediately check the FIFO length and store it (call this length n).
> 
> - Right after reading from the FIFO length (calling regmap_bulk_read() 
> at inv_mpu_ring.c:146), take a timestamp again. Call this FIFO length m.
> 
> - The first n samples (those present when the IRQ fired) should be 
> backwards-interpolated from the timestamp taken when the IRQ fired.
> 
> - If the two FIFO lengths taken are different (m - n > 0), then some 
> samples were generated between the IRQ firing and the FIFO being read. 
> This could be caused by a slow read, a delay firing off the bottom half 
> of the IRQ, or some other delay in the inv_mpu6050_read_fifo() function. 
> In any case, these m - n samples need to be forward-interpolated between 
> the two timestamps we took, since they were generated sometime between 
> the two timestamps.
> 
> I believe this approach will fix both issues. Although my board is not 
> seeing the second issue (where m - n > 0), I can simulate it by adding 
> artificial delays.
> 
> In addition to fixing my issue, this should make the code more resilient 
> to unknown bus and IRQ issues in the future.
> 
> Jonathan, how does this approach sound to you?
Great.

> 
> > It sounds from discussions like something else is broken on your
> > board.  I like the idea of interpolating interrupts, but would like to
> > conduct the same experiments you did when we are running at high speeds
> > and seeing misses - not on the test case you currently have.
> > 
> > The problem then will be estimating how long the interrupt took to
> > be handed vs the read out rate of the fifo.  Chances are our 'correct'
> > timestamp is somewhat after the first reading but well before the last
> > one.
> > 
> > Anyhow, let us know once you have the thing running properly at
> > high speed then we can work out how best to address this.
> > 
> > Jonathan
> >   
> 
> Once I get the thing working, I will definitely look again at the 
> interpolation and make sure it's still valid. If I see any anomalies, 
> I'll let you know.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

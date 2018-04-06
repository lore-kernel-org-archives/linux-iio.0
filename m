Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:51280
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753188AbeDFPZJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Apr 2018 11:25:09 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re:  [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps
Date: Fri, 6 Apr 2018 15:25:07 +0000
Message-ID: <CY4PR1201MB0184AEBA77F8ADB569E6BF55C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <20180328174029.1045-1-mkelly@xevo.com>
        <20180330113606.1eba6011@archlinux>
        <6041491c-811a-8b43-96cf-b19336332ec4@xevo.com>,<20180406161509.0000254a@huawei.com>,<CY4PR1201MB018485BCC65BD470449FFD92C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB018485BCC65BD470449FFD92C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

there is just a problem if I'm understanding well.

Reading FIFO count register under hard irq handler (when taking the timesta=
mp) is not possible since i2c/spi access is using a mutex. That's why we ar=
e using an irq thread for reading chip registers.

I've been able to reproduce the issue when doing a long stress-test at high=
 speed (200Hz). Perhaps this is related to the FIFO error handling which lo=
oks really over-complex for me. I am currently investigating this  issue.

But I would be happy to test any new solution if proposed.

Best regards,
JB
 =20
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Sent: Friday, April 6, 2018 5:15:09 PM
To: Martin Kelly
Cc: Jonathan Cameron; linux-iio@vger.kernel.org; Jean-Baptiste Maneyrol
Subject: Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps
=A0=20

On Mon, 2 Apr 2018 10:07:57 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> On 03/30/2018 03:36 AM, Jonathan Cameron wrote:
> > On Wed, 28 Mar 2018 10:40:29 -0700
> > Martin Kelly <mkelly@xevo.com> wrote:
> >=A0=A0=20
> >> When interrupts are generated at a slower rate than the FIFO fills up,
> >> we will have fewer timestamps than samples. Currently, we fill in 0 fo=
r
> >> any unmatched timestamps. However, this is very confusing for userspac=
e,
> >> which does not expect discontinuities in timestamps and must somehow
> >> work around the issue.
> >>
> >> Improve the situation by interpolating timestamps when we can't map th=
em
> >> 1:1 to data. We do this by assuming the timestamps we have are the mos=
t
> >> recent and interpolating backwards to fill the older data. This makes
> >> sense because inv_mpu6050_read_fifo gets called right after an interru=
pt
> >> is generated, presumably when a datum was generated, so the most recen=
t
> >> timestamp matches up with the most recent datum. In addition, this
> >> assumption is borne out by observation, which shows monotonically
> >> increasing timestamps when interpolating this way but discontinuities
> >> when interpolating in the other direction.
> >>
> >> Although this method is not perfectly accurate, it is probably the bes=
t
> >> we can do if we don't get one interrupt per datum.=A0=20
> > This patch worries me somewhat - we are basically guessing what the cau=
se
> > of the missed interrupts was.=A0 If for example the fifo read itself
> > takes a long time, the interrupt time we have is actually valid for
> > the first sample and we should in interpolating forwards in time.
> >=A0=A0=20
>=20
> I agree with you that if the delay is somewhere after the IRQ fires but=20
> prior to the FIFO read (or the FIFO read itself), then we'd need forward=
=20
> interpolation. That said, if there is more than 1 sample in FIFO when=20
> the IRQ fires, we need backwards interpolation (since those samples were=
=20
> certainly created prior to the IRQ firing and the timestamp being=20
> generated). I believe the current patch is will accurately handle the=20
> backwards interpolation case but be wrong for the forwards interpolation=
=20
> case (though it will at least guarantee samples to be monotonically=20
> increasing, as they should be).
>=20
> I thought about this and I think we can fix both issues. I propose we do=
=20
> the following:
>=20
> - When the IRQ fires, immediately timestamp as we already do. Also,=20
> immediately check the FIFO length and store it (call this length n).
>=20
> - Right after reading from the FIFO length (calling regmap_bulk_read()=20
> at inv_mpu_ring.c:146), take a timestamp again. Call this FIFO length m.
>=20
> - The first n samples (those present when the IRQ fired) should be=20
> backwards-interpolated from the timestamp taken when the IRQ fired.
>=20
> - If the two FIFO lengths taken are different (m - n > 0), then some=20
> samples were generated between the IRQ firing and the FIFO being read.=20
> This could be caused by a slow read, a delay firing off the bottom half=20
> of the IRQ, or some other delay in the inv_mpu6050_read_fifo() function.=
=20
> In any case, these m - n samples need to be forward-interpolated between=
=20
> the two timestamps we took, since they were generated sometime between=20
> the two timestamps.
>=20
> I believe this approach will fix both issues. Although my board is not=20
> seeing the second issue (where m - n > 0), I can simulate it by adding=20
> artificial delays.
>=20
> In addition to fixing my issue, this should make the code more resilient=
=20
> to unknown bus and IRQ issues in the future.
>=20
> Jonathan, how does this approach sound to you?
Great.

>=20
> > It sounds from discussions like something else is broken on your
> > board.=A0 I like the idea of interpolating interrupts, but would like t=
o
> > conduct the same experiments you did when we are running at high speeds
> > and seeing misses - not on the test case you currently have.
> >=20
> > The problem then will be estimating how long the interrupt took to
> > be handed vs the read out rate of the fifo.=A0 Chances are our 'correct=
'
> > timestamp is somewhat after the first reading but well before the last
> > one.
> >=20
> > Anyhow, let us know once you have the thing running properly at
> > high speed then we can work out how best to address this.
> >=20
> > Jonathan
> >=A0=A0=20
>=20
> Once I get the thing working, I will definitely look again at the=20
> interpolation and make sure it's still valid. If I see any anomalies,=20
> I'll let you know.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html


VGER.KERNEL.ORG - Majordomo info
vger.kernel.org
Very short Majordomo intro. Send request in email to address <majordomo@vge=
r.kernel.org> . To subscribe a list (``linux-kernel'' is given as an exampl=
e), use following as the only content of your letter:

     =

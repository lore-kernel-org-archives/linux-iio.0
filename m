Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984C175A64
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318158; cv=pass; b=GJFOtnfVbPVoX35mX+RsnYTo/s3ixpuiLHr7iKm+DY16NSVr5W9O8DawRiSXaycsRVAzgX/JTzHTCcAmqVeZMw6YIx1gAoFmQ8ICcYfmt6l2XuFAAhGoWoWMuAl9Gl+r9psHhFI2MJKN7i41BoTsAebQxfRgWqHDs5Y6xwXiR3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318158; c=relaxed/simple;
	bh=3RJjhNZDgt/Udg8v3PbnF5YZOtpiIdHG3dBCZycHVDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciSj3hHIhg9KyrDwLaBqkvOMunjZNpXSciyDNXVGUsq5OdC+itJln3wzHI4WN5p5EiuqmrUw7WV82s6PptuyueJWvmqKDZS4Ad2B3uPf7reJsB/5h1bHR1XOKNN2duma0vwEMSQfkbHLOM6mjxMfpq/EqPQkcQ6D8OtT/2eVHDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+167mmd; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+167mmd"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44a044cb827so2119794f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778318155; cv=none;
        d=google.com; s=arc-20240605;
        b=iuzqBm0K9o5dug1foe+j2pAmf/BKSklT8GA8s4Qiksc2Lzwd4LQOUALupu5p/uPiCB
         2FLSRoHoLElhWeI/Bm4oZk07MHaMXDWKKWqpSIv4QNMayoDghXRJXAY8Pg3FarUU9mzO
         PmaSM+WLesv5w997iYERDr+fgF1ROp3ZCt3HKoHAPIAMbzFG7H/MsxLuyuJg+9PSqWqZ
         4Mhtc2tfDNKdvbxGPP+bdPrbKXYIDiXpyQfjcF2Bd463PeF6UV3HLu9BEHx8BmCD6pE/
         niS8m8JmGxpVh1KN6iL/EXkEaQSETyLJJmR/PK/5PpsqZRfQ2F+R/FdyqUeLjjfwa6VM
         J+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P5aX7XBLMi8K0DozV2u5tZC0rS0LSpDKS5kA5HDR0j0=;
        fh=NmrpWR3EYN5yV/p+Bonitwb4xjx2nqaTAUaX40eFr3Y=;
        b=YsW4TaCMIIkHISt/hcuswiZsSbUuRw7r/r+pqpONVzYsioz/cUXwTlb5RG5O8AdjQa
         8iOyl/lG7smkpLBDuVmjfq3dLCfGDVTV9F3ZhIzub1g8MjUEyuZXrt2BecQRaQyb2kDe
         Ge09uv/0kgyHvPZn78iwi13k7ljQot6dZ0C4n07guhrlNLaQEEcgZFP7pRq680+79JOe
         Zwh0NHRv01VfW6qc5JkvjPU5rlwMoFnPvy5+prOTUue3SIlWeEDPxYfJ4E0reC3YjXGc
         rvDaO6+jNyfYFANG44qtD+EXRhLZLW/YsQODTmeSOU4JLME8gifOa1XbOD09vxs5/fU4
         HNag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778318155; x=1778922955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5aX7XBLMi8K0DozV2u5tZC0rS0LSpDKS5kA5HDR0j0=;
        b=D+167mmdFq1GTQiTfAlh7o12Kw0jYqn2bCCyOYjSF2OwIuRdPkW2zdTayzaHazuzSH
         FNPBxeZizl+T9pFt5MjgdMAS3kYTV59dfk9fK71kksdrM7EN4exKOhYNHMFo+evmzFkd
         ZCMOqjB8UdP5MrBrghsIPxSWQ7ZVLZYEue0xb7Re5k+k5KUi+psa9e+2SEHXrm1+4JA2
         tJmXWcFdqjtuVi4y5vl7H19NX4TNAyFXKPTnFuuRxnDeNzlIZoq5lL75KVIw55aEVMGk
         OopXp3yZl5ucmDQNolKWJpNqRQs0l66Lmqkul/9gd8NKH9N+Xkx4Z/zOIgWiXMdfWQbF
         tLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778318155; x=1778922955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5aX7XBLMi8K0DozV2u5tZC0rS0LSpDKS5kA5HDR0j0=;
        b=EYdec3/hGMTYERbec3543YngRmbTdWivdqe9A164CR0D/H9jipG05c4dRf5q2h3R+i
         cJd9QTv6UrFb3BFicK5JAXRSFi03J4hLF/MYZaVgzJqCFYNwHnOxyPCfiVN37jBUfMxn
         gsduY7zRjwSKKiIVri2uBW79UziDYEDjLYKKvssS2oKM6V7jqtH4oG2hJ3yMQGlrxslk
         VHKzLwjCgtlZTSmv5hZS5u+xMDked2ZiWri/OGH7UjAtPSQj5GQHXbm3uLbuU6JH6k1d
         eLYQSLRXEtShLysw8YF82FooXm8XTvJU4Hz9st6h5Qe92eyzjUAs4Qi/GaNXnfVYBrPS
         wiVA==
X-Forwarded-Encrypted: i=1; AFNElJ8cbiMybhEWIjioiVSKSk4OGwuz4kQd/OyvEGUs8JmWv0UcJcjnBqjaTmJts+u0eb0t2UkzQM6FN5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYsF9yjQgmazyTPp95j2+rLhD4lpmlzRAKp/fvW1ssZIaN8cd
	+mdGBJ/j4Hm7xiBNBnta6tAvJhqYaof6/VDVCEmty8OfGIDupUDHtItKI2wyGyFgIxGhpKbQ/xv
	hnTubzU5oFe3YBv6ywIVqEr1ErgU9BTw=
X-Gm-Gg: Acq92OEpXaCbBPmTGHe9jUjCOoP4OEPR7ALjiC7ykVrr0fXnwJHvFK7YSvQTSds6R1Q
	M+LX6uAUFN0GUsgtB9ZgL/VcmH9ysdMiFWTaYINyXYkvSsuv/aHPDM7kIPmRVlDQ4y88CiQMrLh
	V/A4Jp63zJlZWzyFMAgY6uyNfIh4zIM3kBYFASRdlNRInh3CAl1EBWJnHViMbGw1VyyXvmYQnlh
	I4UKZurpwvs6vRnKIPSYULQylpMZc69BlCjKMvRnhW10d/mo20vzcW6TGx+b5GGOpcFwJ5SkuaD
	79qOf/o8mKF3oNpYNaPjAzgEmbctLReu2QzC+3OJ6gWLXz89J12bxqeTaIFA6mp4utZgQ3rmxFt
	wP185wpWwRDzar2ZO5cPCU0zg9SopAkOBESB5E0Eo52pGdcZr0QlYbEQAkNpb/pMopkc5lsghWr
	kxi4xj2w==
X-Received: by 2002:a05:6000:220e:b0:441:1fa5:457f with SMTP id
 ffacd0b85a97d-4515cf1273emr28190435f8f.28.1778318155282; Sat, 09 May 2026
 02:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-8-37827ca68fb3@gmail.com> <c0909d796cc6568be96e6afa795c83e2f9892524.camel@gmail.com>
In-Reply-To: <c0909d796cc6568be96e6afa795c83e2f9892524.camel@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 9 May 2026 11:15:44 +0200
X-Gm-Features: AVHnY4IWKRpP3NZtQ8ttgli2w8jrt7XXHjfZuuzupMjUKmRcN6FFkBsnMM6NIxs
Message-ID: <CALoEA-yYuATXSWuHxNCqDYB8Qj4ct35RZrYsV88nr=TCMiE1yw@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: magnetometer: ak8975: make use of the macros
 from bits.h
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 May 2026 at 11:08, Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Make use of BIT() and GENMASK() where it makes sense.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
>
> Small nit, anyways:
>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> >  drivers/iio/magnetometer/ak8975.c | 26 +++++++++++---------------
> >  1 file changed, 11 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetomet=
er/ak8975.c
> > index
> > d11f025e146d098508f35ef31c1ccad544612535..d8d9f706f96bae3be19e8db17b947=
3e6e0eef4fc
> > 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -45,8 +45,7 @@
> >  #define AK8975_REG_INFO                      0x01
> >
> >  #define AK8975_REG_ST1                       0x02
> > -#define AK8975_REG_ST1_DRDY_SHIFT    0
> > -#define AK8975_REG_ST1_DRDY_MASK     (1 << AK8975_REG_ST1_DRDY_SHIFT)
> > +#define AK8975_REG_ST1_DRDY_MASK     BIT(0)
> >
> >  #define AK8975_REG_HXL                       0x03
> >  #define AK8975_REG_HXH                       0x04
> > @@ -55,15 +54,12 @@
> >  #define AK8975_REG_HZL                       0x07
> >  #define AK8975_REG_HZH                       0x08
> >  #define AK8975_REG_ST2                       0x09
> > -#define AK8975_REG_ST2_DERR_SHIFT    2
> > -#define AK8975_REG_ST2_DERR_MASK     (1 << AK8975_REG_ST2_DERR_SHIFT)
> > +#define AK8975_REG_ST2_DERR_MASK     BIT(2)
> >
> > -#define AK8975_REG_ST2_HOFL_SHIFT    3
> > -#define AK8975_REG_ST2_HOFL_MASK     (1 << AK8975_REG_ST2_HOFL_SHIFT)
> > +#define AK8975_REG_ST2_HOFL_MASK     BIT(3)
> >
> >  #define AK8975_REG_CNTL                      0x0A
> > -#define AK8975_REG_CNTL_MODE_SHIFT   0
> > -#define AK8975_REG_CNTL_MODE_MASK    (0xF << AK8975_REG_CNTL_MODE_SHIF=
T)
> > +#define AK8975_REG_CNTL_MODE_MASK    GENMASK(3, 0)
> >  #define AK8975_REG_CNTL_MODE_POWER_DOWN      0x00
> >  #define AK8975_REG_CNTL_MODE_ONCE    0x01
> >  #define AK8975_REG_CNTL_MODE_SELF_TEST       0x08
> > @@ -95,8 +91,7 @@
> >
> >  #define AK09912_REG_ST1                      0x10
> >
> > -#define AK09912_REG_ST1_DRDY_SHIFT   0
> > -#define AK09912_REG_ST1_DRDY_MASK    (1 << AK09912_REG_ST1_DRDY_SHIFT)
> > +#define AK09912_REG_ST1_DRDY_MASK    BIT(0)
> >
> >  #define AK09912_REG_HXL                      0x11
> >  #define AK09912_REG_HXH                      0x12
> > @@ -107,8 +102,7 @@
> >  #define AK09912_REG_TMPS             0x17
> >
> >  #define AK09912_REG_ST2                      0x18
> > -#define AK09912_REG_ST2_HOFL_SHIFT   3
> > -#define AK09912_REG_ST2_HOFL_MASK    (1 << AK09912_REG_ST2_HOFL_SHIFT)
> > +#define AK09912_REG_ST2_HOFL_MASK    BIT(3)
> >
> >  #define AK09912_REG_CNTL1            0x30
> >
> > @@ -117,8 +111,7 @@
> >  #define AK09912_REG_CNTL_MODE_ONCE   0x01
> >  #define AK09912_REG_CNTL_MODE_SELF_TEST      0x10
> >  #define AK09912_REG_CNTL_MODE_FUSE_ROM       0x1F
> > -#define AK09912_REG_CNTL2_MODE_SHIFT 0
> > -#define AK09912_REG_CNTL2_MODE_MASK  (0x1F << AK09912_REG_CNTL2_MODE_S=
HIFT)
> > +#define AK09912_REG_CNTL2_MODE_MASK  GENMASK(4, 0)
> >
> >  #define AK09912_REG_CNTL3            0x32
> >
> > @@ -848,7 +841,10 @@ static const struct iio_chan_spec ak8975_channels[=
] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
> >  };
> >
> > -static const unsigned long ak8975_scan_masks[] =3D { 0x7, 0 };
> > +static const unsigned long ak8975_scan_masks[] =3D {
> > +     BIT(AK8975_SCAN_X) | BIT(AK8975_SCAN_Y) | BIT(AK8975_SCAN_Z),
>
> Small nit: But maybe GENMASK().

Well, actually it was decided to add an enum and just do a bitwise
OR of the three BIT() macros for better readability.

https://lore.kernel.org/linux-iio/20260506181216.049f87f8@jic23-huawei/

--=20
Kind regards

CJD

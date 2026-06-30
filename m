Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4621CC51
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828014; cv=pass; b=aFqLBieUBfHeu5ZblpdW8iT82FRSX8jof3AgV6yrsdRHoRUgiHVtesy0rR7FPNVe0/HhZbAHnmpo2ftaApU4QhwaouGUrehqlHBFcqFs+S00iuxekvZ6O7YsYHLnzzPkrAqVgEswUGdU2r/pRi77tCwut6Y+VpvQGlZID4crtRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828014; c=relaxed/simple;
	bh=Pf9x+5PrM05EeH6aQco2tajyQNOVVCGtBB+201fkglA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTpP/empf11jmabygGtrKUOPZTgt+h4TKTMoIVCtBhBaNjtZgdUe0H5DnV9txjdiXdg4z+1ZkVbEd7G9lBwf4qGIESjbPQLU1HWm3WGIIeQA+E0dMENO7ieYyaMMnIGLwFFq94ZHM9GSp90FaeuACGJgvij1WEH8OKR4XWuHMYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT7e+GaU; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT7e+GaU"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664d910cc75so2319396d50.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 07:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782828012; cv=none;
        d=google.com; s=arc-20260327;
        b=orZAeFWGQeZP6uqdv6fwN28wuoOH5PMWuNdkJSqxpdMyBBDD/oCt/D8pM1PbzUKBUR
         0zlPQSdp2vaF++akU3UwX4O8X+2/aaFHffcxLYz+o7AoPRVMZra7BUncRo90p7j7Rx+g
         JRM1m14ku5aCvEdb+Ujl9Kf59597GYcuVqOxiTDBCxCwGmvD+UAOEARK5WVtWV1DxmbE
         t2T9nhWf18ncFWpTfSA5lNIPZnn8A4fdDvyHC7oESF20qAI0MeA9uMIx8frKQEBzlGq8
         nH26QC6Zeml70erwm8Q3NPdunU+5tfEm7NoqhldcGUlvCUubhNeSRbPbp4e/j0YzEvju
         GzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CMVm7Mjs3qErz1q27EED+5ri+HNyVRB+cg36GULIwIk=;
        fh=t5DDh+w5FnNCV7/LvnCEDdT287HVfRe74g/pPlQeFSY=;
        b=AUHOd+rj7nhImcUIauvc33FbMHph0W6/5IvIYo+fM812SObtsxYTzqQ1QwO3qT2KZU
         6Q4iAI1Qmvn6xe515yapR41/3/zQOa2MOtBBXmvcVtZz0Fp5B3ZVlKlTB/jhXwxZ6a0p
         QD+1z/vp8vajbDl/izL7AuWHeaLHWkJ8tTY6GRu8G82716kfnIez1eoCQG+wEErxb6ji
         /iUnd4qBuEbd6HG9IRH6L6A0wzsVv4Hl1QN6iCs4jPUV+qiVX4UPbgoZMfx/4ys7dGyL
         NkXSfDhsl/fOoXcyMpAvJdvTknEdXNwv1Bv7HcH4aEkR0Xqgf+rhG496noTXYg/zq7uM
         ymhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828012; x=1783432812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMVm7Mjs3qErz1q27EED+5ri+HNyVRB+cg36GULIwIk=;
        b=kT7e+GaUGrQD0bbcfbAxaxFC509omUOHqpekMa1L2/v0CLTQb07wfXz4zx4VoFyb6+
         bDgv3akhUmNgmulA/zU5u9GbPL3oO3Shbe813cmuMcUimD5vrOHG65VZl9CGRUGUmib3
         Mj/sVaD3mmewbezmWdnyU6Erl7q4Fg/R7Dcna4r9jyQXn5AfYonaG+vzWUTKHvYbL2ky
         NnFDIOZLaMhN+UBhbXHUiRZun5YZQgpVD+FLR1xS1D1n4nscZmFU4sdk9lc5ZUyuVH8t
         zyG4SZl0n4k0IQqUZmH2gEUy++jRJTH0jkvICcLj+0Yehq79qlSjHgqL4GJzVH9AwjRu
         xVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828012; x=1783432812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMVm7Mjs3qErz1q27EED+5ri+HNyVRB+cg36GULIwIk=;
        b=lVsN0qKE5Zbn8IoSJi6vkFIBCwyI/C0QwWyt9wRXE9cPpUDIYAqtXdChq+sbxvI+lc
         numDKBsQve6TwrCmsV4y5F24QD1awLQvphfOL9JLh5dpz+Xw16HNMkq6U9McYa18/g7b
         XibDniCzYZ44dQj5swTtaYfAyhSJLDJuvN1FM0ITGpY5HmJdC7eTA7HTElCuIA9IRxom
         Vn+AFiICi0o0kIocziOE7V8lMch6VlK8fPercsqDOgb/dJhpCu8PEhSUZaVBm+3ANzkI
         slNbeTDaLF4Id6yLPw0DUq6/6Xl39pdBnYpKxLwJG0qFYgCJmFSuHSdSQD1tFtXcBqYt
         O2zA==
X-Forwarded-Encrypted: i=1; AHgh+RpHYXMhbLqZ4CdPRB9upqMzUrUCxwDLzwhWYYM4xi5DaR+PK5CenLVd+tVCLCHY602hl7R5orcTyiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLYFPPovDqqv5CwLj4RXxAIdk0l5aWsCQkLEqY+KjzR1ibhNn
	rAZnDXveoDtWL7xrGr48H+zapcPTHWpglR/JdFmLUGHaEeXN7b9yl8AFq4u8P3ZOT53EpvVKVat
	3cZYov9gNrkfx4LwjFsvhbxyl+QYxsGw=
X-Gm-Gg: AfdE7cnmS7NhM5TdnFP7ewQlq4DRhfNWYwOjwYA3Iiuxdmz+qVdqsl7z05F7h9lDyOf
	vMuMf/YUThGKx0vn+lLqCguNo7m+QfNbfEuF2nISZBTYl4m8dC7+AnXBAQnhaSs5XQ1pbrd1RQ5
	x2O5eIrpWvqLyEdmF4qGOE/O1/gqjMybt7dj3HFVTb0PC1vCak7XMRjk1TtQFBEY5PcTZ/s196c
	pZbDgL6fR01qEqRp+r4hZF6aWPaW2rvS7Xb+f1h5WgqLzs+N3JN2SHAzQGZ6o9pWIiGSEYx3wHA
	rxPvTkxS7X2mzPyTZCDnilRV4cI=
X-Received: by 2002:a05:690e:d5b:b0:664:a1a9:9921 with SMTP id
 956f58d0204a3-664f98c77e8mr3535595d50.48.1782828011478; Tue, 30 Jun 2026
 07:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
 <1235808b-34bd-4d9b-ba23-158ce3f113d2@vdwaa.nl>
In-Reply-To: <1235808b-34bd-4d9b-ba23-158ce3f113d2@vdwaa.nl>
From: Mert Seftali <mertsftl@gmail.com>
Date: Tue, 30 Jun 2026 15:59:59 +0200
X-Gm-Features: AVVi8Cekb8ShVXFanDlOYsrut1VaRuav41eP5kGTReum7B25AX8p1naCERR1mVI
Message-ID: <CAA3NooqF=FE+gQT-CzAUv7eo7D=wQB8JAeHuc=XNSB0KdSd=ZA@mail.gmail.com>
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
To: Jelle van der Waa <jelle@vdwaa.nl>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 21:06:..., Jelle van der Waa wrote:
> Thanks for digging into this, I no longer have the device in question.
> But the vendor driver can be found on GitHub:
>
> https://github.com/minstrelsy/mediatek/blob/.../dmard09/dmard09.c

Thanks Jelle, got this from the repository;

It has the sensitivity, and it's used in the driver's own conversion:

    acc = raw * GRAVITY_EARTH_1000 / sensitivity   (then / 1000 -> m/s^2)

with sensitivity = 32 and GRAVITY_EARTH_1000 = 9807 ("about
(9.80665)*1000" in the MTK header), so 32 counts == 1 g.

It also clears up that bit-twiddling i was worried about. The vendor does
'data >>= 3; data &= 0x1ff' plus a sign-extend of bit 8 on the 16-bit
read, i.e. a signed 9-bit value (register bits [11:3]), and our '<<4 >>7'
dance lands on the exact same number. So the 32 applies to what the driver
already returns as raw. Self consistent too: 256 / 32 = 8g, which matches
the +/-8g.

So this time i think we can implement it instead of dropping it:

    scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB

happy to send that Jonathan, it's the vendor's 32, so same
no-datasheet situation as before. or just drop the scale declaration if
you'd rather not. Whichever way you point.


Thanks,
Mert


Am Mo., 29. Juni 2026 um 21:06 Uhr schrieb Jelle van der Waa <jelle@vdwaa.nl>:
>
> Hi,
>
> On 17/06/2026 17:53, Mert Seftali wrote:
> > Hi,
> >
> > I've been digging into IIO to learn my way around it, and the dmard09
> > accelerometer driver caught my eye as I think its scale attribute has
> > been broken since day one, so I wanted to flag it.
> >
> > The channels advertise scale:
> >
> >      .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> >
> > which makes the core create in_accel_scale. The trouble is
> > dmard09_read_raw() never handles IIO_CHAN_INFO_SCALE, it only does
> > RAW, and SCALE drops straight into 'default: return -EINVAL'. So
> > reading the scale just errors out:
> >
> >      $ cat .../iio:deviceX/in_accel_scale
> >      cat: in_accel_scale: Invalid argument
> >
> > and userspace is left with raw counts it can't turn into m/s^2.
> >
> > To be clear about how I found this: I don't have the hardware, I traced
> > it through the core (iio_read_channel_info() -> read_raw() with the
> > SCALE mask) rather than seeing it fail on a device. But the path looks
> > unambiguous.
> >
> > I went looking to fix it properly; add a SCALE case returning the
> > sensitivity, the way dmard06 and dmard10 do, but I couldn't find a
> > DMARD09 datasheet anywhere. Digging through the list archives, it looks
> > like the scale was declared in the original 2016 submission but never
> > implemented, and the driver was written from a vendor source without a
> > datasheet to begin with. So I don't have a real number to use, and I'd
> > rather not make one up.
> Thanks for digging into this, I no longer have the device in question.
> But the vendor driver can be found on GitHub:
>
> https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c
>
> Greetings,
>
> Jelle van der Waa

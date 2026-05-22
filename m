Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E237756F
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451578; cv=pass; b=JpBIfwxO4Syr2W2kFgKkEPAkWU0K5ivaafXikdgIxpiRi3kt/lHa02e5/w1Js84tpUQnJGDj6Zs9Q5JAjWKBgIKrO5kXtN5WdRJlpx7ZxsoUjwRoJhZ2I4iRHHPN9i5ANNCPMlR+ed8++ZaRmf4IiWa2nHsQX+blRPaAk0XYUlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451578; c=relaxed/simple;
	bh=S379vmTEW5eNFHPjAqjoSMatVzTvzwfba67FIWPieKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atO2ImkEGjvV0dZdEQ2ic442YLKAUl6ZoPWDC+ipIMa3Mm7nxTEhUgW68XiDdABV03dGCLbUv0TZx18T9ticynqShtb/ixvBQMmSkurNcbtGOlEFwvi+9BA8uhstoFcpzuI5JjbSlbvnplO+nGGbkjhiz1cquCCogykKAUFtN6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFoOMJDF; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFoOMJDF"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe608cb92so4494931f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779451574; cv=none;
        d=google.com; s=arc-20240605;
        b=RGaQM10NfaF175EZQHdcZ5NsrKR+LO3gSzXlJ/a4j6u8RxBxqAXKTZdG5fOZp/OWZB
         188swh8SxRPnUYV6rBPJvQu0rb3XRUgHkEM3C7jLJ0GVE3KJf8QFhlA41QserCbXetsN
         QiJThtRH2VwdeH16ZIFrDd06iePN+3aR1mbV2FY7YqSBwgHx2AXsnAOAUXjfJ/1xaYTa
         WJ1rlMcdici9zS09EacvWrjrrybGyVnlYU2/1lQsEDD50xPU+JHdl+G0dCZ9bCjiiyTk
         v/Fq967UROoc07fnG+VEPBdQbzKqt5dY6lqKyVBL4MNgZmSbkCZhtKiY7Z5MyEJKnZzA
         6llA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zlr8jFcUf6KgzQpbWFYRrxBWB53Px1rf/3Ff+E7fo8U=;
        fh=lTWyhOvLmUXysuCgm8fajOCf9U9jbThvmlzKRXt/2mg=;
        b=TpBF/tUdwH1cDvP7xr7+B6bfZutvRCnVFagGYKg2NVb5SNK/gFUAcAlGVJsEDHrpya
         vOtVaEqYYhDXma9z7I346kbocvXqVGkza2lvEL0ypicHVWyLkPqte0XRqxy4byo6xqo4
         +xItGhU0E4ybK+8KYauDQSDxXycrr9m5Vto2a6ZSKYyVDdeTOeIj9lM7RA84b0JY2C1r
         HeuiE/KMs6PS+2y7DtOWkw8zWkdXQuE1GAnizM9vX7vwyP4HCYh3VbT9bdybbN76tzu8
         MbfvjdYji9IpnrWZciTGF1H4SL5N6XGO/M3b6XoxcgA2A86gi5bQE7ipJnlcKA6yjIui
         7V0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779451574; x=1780056374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlr8jFcUf6KgzQpbWFYRrxBWB53Px1rf/3Ff+E7fo8U=;
        b=aFoOMJDFgThybXp//pfHgZwEaMZIx+f5nyY0AICx+AB0WrSgibHW7XqHSpQN2L1bKs
         0jt2+8IIwBgf8vfx+8ZjR8FbuAdqYxkKVUT8+i25UinH0WHK9wWBQ6NiBpzABSmSvwfY
         7Lr4vkEvGLNb0BZcw3Tyj78PEGZ8EAR+1sFJ/A5vAHpX4mWH4omIQS2BR/1bp/tUiq+5
         Dwa/AKyQzS7U4cDBhYZvjBEfNu3NhLGB/mlZduGtvvN40ozhiXL8cmshdQPYioCmNpkN
         AawkdATQBetwBO1S/VbLt63tuqgwXckfnWzDwFc5aeQrAZnJ05lu4tWC5o4CrqeNVwaz
         cNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779451574; x=1780056374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlr8jFcUf6KgzQpbWFYRrxBWB53Px1rf/3Ff+E7fo8U=;
        b=iEKmeWriSgTC8K2E4j6XMOMD+EZYqfTfbPvQCZr/2Y2Q8QJyhbNG8Y2WY+s5xkS1wd
         H84KIvSD6tqyTPU7OYtnw1unm/AXmAo8lR4ZEGzMc9D2rkzHrlTiTHVgW/DVrHHfboVh
         6wwZi3ZoVo7fge3Tu+8cRDNo+IpCcgqnkwRqCXlh8q4aZspaQ2uECk4M4mOE4QhDgmYU
         7Osqd5HIUE/ms5Mrf0EFSniztYMhGOO30x2kXcnmptmFYXSWmFSnV/O9sb0Dor7TSCr+
         piChZL1dpqg7PFZtFAz8g/4jFSfq9+I9H5D4YrKK/5LFkrZbFE1p/zaaoAu1cGdAzQUW
         Uf4Q==
X-Gm-Message-State: AOJu0YzXgfQ6YAnyGoTe6ZBbZRhe8AVttIxQOqozBvqhfvE50Kd3vB5r
	vfvO1w02kxgxn0n3NH99bSLy082TTpiyvBwnwBPY5WxJlYjXM7Q59dlyAygcJ23VT1dz2pelKdu
	1ump1MmEb1/zBw8o5Efr7tqRKs+4syFw=
X-Gm-Gg: Acq92OEdCRyy731Ty+a7uLqZRH0FbWxuEePJ88cN7Y9BKNThADc2GjIrpDEVIkPI/Eo
	6KYV+PJO5BywIz3wllyWz1+BizDIzWycdsHKk6eRYu848Gl0r3/sYiO8FTTftqdU662uFr0x5w6
	PJmKxy7dwtfXw9i/1E5th1J9jDfRcTx8zQolb5Vj0/h5HT1045pfVd8f8kN/PiSbXT1kBmtUYT3
	Mhphr7LJy85vgE2BXpafnHGKYEqf6Fls3T6nOqMTRmE5GHRyB0BOLNtCWI/Tf/+LnW4LsMMUeR/
	2ggCRMoX3qGBSsz4ZDK8PAbl8Uq2oL6Z+HU9KrSkFHGnw2+IHiCpz7LgIoU2HGhNNciCSQjvMBL
	bx7veLvf2TRlWtFAn9NP47ddIKC4badcvm7Vl8AM2NBDgYqQHd5Xfjh5N4MyCxaDrmQSCEY9lRv
	asymRh7A==
X-Received: by 2002:a05:6000:2411:b0:43d:775b:c9bd with SMTP id
 ffacd0b85a97d-45eb38a167amr5345100f8f.10.1779451573800; Fri, 22 May 2026
 05:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19e4f819ed9.2157dac799522.5155742748768717789@zohomail.in>
In-Reply-To: <19e4f819ed9.2157dac799522.5155742748768717789@zohomail.in>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 14:06:03 +0200
X-Gm-Features: AVHnY4LpwxbYYvwer3jj2y7HTrbBWsmnDsITzcU3lPPwA0PNg1Zv170sRDkC_5A
Message-ID: <CALoEA-wqW_D6mPFZnLpgxwakEWw0=bF+e-9iFvc3aSqsGYiF6w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: fix memory leak in viio_trigger_alloc()
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: linux-iio <linux-iio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 13:53, Ashwin Gundarapu <linuxuser509@zohomail.in> wrote:
>
>
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Fri, 22 May 2026 17:11:00 +0530
> Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
>
> Separate error paths for before/after device_initialize().
>
> The free_trig label was used for both early errors (before
> device_initialize) and late errors (after device_initialize).
>
> Replace the unified kfree() with:
> - kfree() for early errors (free_trig)
> - put_device() for late errors (free_descs)
>
> This prevents put_device() on an uninitialized device and
> ensures proper reference counting cleanup.
>
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>  drivers/iio/industrialio-trigger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 9c72e7ae996c..39208c65e6c1 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -597,9 +597,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>
>  free_descs:
>         irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> -free_trig:
>         put_device(&trig->dev);
>         return NULL;

NACK, this is still introducing the same bug, device_initialize() still hasn't
been called if the code jumps to free_descs.

You're trying to fix something that has already been addressed, see
Jonathan's response to your v1.

Please note - wait at least 24 hours before sending a new version of
your patch, the more reviews you get the better.

--
Kind regards

CJD

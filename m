Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8237E301
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033325; cv=none; b=e5Xu0ph0CFLsTCOoDu7CXVxjYM5DwZZ7kZgunzmYxBE9c69n/eWXHZSu7CO86lRocnaw25vTD4/OC6vCD6OECTBryLVsRcs5LNJm1KWoDV+cYGArI/P3+ovtwwFqC4xy0TqtOxv3Gy4Ruh/N6fEuyltaj0CDWROQpxfq+WjHILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033325; c=relaxed/simple;
	bh=rF2fjIczSR5/O/w8jUrxzr8qaMT2qPjcyQns/bTHSkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeyYJOaeIyZQC7oXPY4s8lPBAOISjyaDtjkuI6AptW7Lt3tqfMhUZi7leyi4m90C34V9QLYnF9WHKcFf+S7oY4+jzht+8aKyE4oqYe6RF2OsLi9U43iBKCgbDrpqhQ9uHaHlWDSK/IjWsWsTqHI6pQk9kqDiGOvxUhsDvs93iaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suK8qX4H; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suK8qX4H"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304c520fe9aso4581992eec.0
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033323; x=1780638123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk0hlbm0P5JJAGntaPUrnolV3Vq6zGWkmyfbWRCDuAQ=;
        b=suK8qX4H+aZYsl0m/Ogzd8nWGEkOhR7MgKUnr15Ddf0+JaJIuyhla3sbOqhRW8yoHV
         60WotZU8ozBMZqt0G77dO9FD++NUPoxnZsEaMSdqFs9EML6ht1JeXrtLFFj9en5iHzAB
         rCZISnIykYqAfvfTEpCK9gat7G/D4iUOLJrhOl+6V1bJXVQ4nToizTbtcasqSleT6sBG
         xNMhzsGeE1Lk3o+NP/VX9ayfyJMsFKN0HinxFgLsLoY7234HCZAv3TWQEnYfFBAlL0fb
         TQ2cwHx0aE7av6cpM/JyTiyE4oj2Sezw6JPtp66m9mc7oF934bsZcw+kpLA5NXbnC3a+
         9lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033323; x=1780638123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xk0hlbm0P5JJAGntaPUrnolV3Vq6zGWkmyfbWRCDuAQ=;
        b=IfuL75TQheMBYBl4eqHg+wBQitaKu1RBqvpVFJT4nFIGKRe4X91Sscr157MyiYSWO4
         29czk8OeOvSGH74DrgvgmaatjGP8Cx3OTmL6MN9xPHfTXRBzJvu2zL3vgWxeqWNmhEGU
         1weNM++La+U/usTKKlMQPg/2z9t54Sije7r6TfplRrnSPYw+6qIM9G7dO3D+RX8mRZhl
         yKMkPOJPnjg3IocGL7pLe2mX6YXNLC59uDSOMZR0PreReqA0FWwQt0fZz9NhiDexbPAR
         nKSMbNZ86T1yeGcPMPYmqdvv33K0lz6PWr1q9tavrabW7XfCQG5ZPAdgsaQvkWMqdAu7
         OPew==
X-Forwarded-Encrypted: i=1; AFNElJ9SxNcdFfrU7MEhylppCgS/RdOM8qaueHdX0kmy5ZLcNkDW+CtmuchDBjYsEVaCG2CerdKfiRNqn4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8j7VocJB6IzdDJfR7gmEZCd1nGRLRRryO0G1DOOeVReXTXL89
	LoG7FMpT9TvHIz0/5ZKTfX2tOUPzACI/R7Fzg9xMFCPuh8c9qdi6Oz64
X-Gm-Gg: Acq92OG2muU+YwFIUH3B7cf3Lk/YYgFBvcWHWWrOhHbff/NDy758vM1B82OLJIDviJa
	FJ1qLaCtSybp7KJq+1hqBoaj3QiaRzvH4Yg17Q+aqE7O0J4MEJE85ok/V0hlCdjMhfTnWPIPlU3
	InLxsBQR0Wjsx27u9sHnC+bt+bSqvXujKyfjT/eqOXjAPjY6fhM67OWGHSjFie7FQP6lufOUtLL
	XpT8MjW96J6G/6b7zRTQA4xYYjFvGSjqjMxcG8tlkzEo+9vF0JdnOT8NtR13r7fKtMqhZiJN1Ov
	divCuWN+k/qhYf/qlNxkN9QurifjXrmkBplxbjOtI+8TF7T+bLzKLqa8E/m6GXwLNPOsV5I4g2L
	5H+NpJ/M0H+GYh0a3Ww/33wS/y6i+5JBonH9iwXNdkY9rMUaPz5FhX3neTc2jdxef8+Xm0AXcot
	q0gPaszo0QUkGeiBaX65ADZRZ0qzq4DNJM0C9Uiw==
X-Received: by 2002:a05:7301:4196:b0:2de:cc07:e99 with SMTP id 5a478bee46e88-304ead9b7fbmr734452eec.7.1780033323236;
        Thu, 28 May 2026 22:42:03 -0700 (PDT)
Received: from majuro ([2601:644:4383:1c0::4126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed30fffesm620713eec.11.2026.05.28.22.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:42:02 -0700 (PDT)
From: Brandon Saint-John <branstj@gmail.com>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Brandon Saint-John <branstj@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: Re: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams AS5600
Date: Thu, 28 May 2026 22:37:56 -0700
Message-ID: <20260529053803.3256031-1-branstj@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524132824.54918-4-muchamadcoirulanwar@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 24 May 2026 20:28:22 +0700 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> +//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
> +//!
> +//! Datasheet: https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf

Small nitpick, but going to the above link doesn't resolve to a pdf.
The link that works as of today for me is:

https://look.ams-osram.com/m/7059eac7531a86fd/original/AS5600-DS000365.pdf

> +fn err_enodata() -> Error {
> +    Error::from_errno(-(ENODATA as i32))
> +}

Later on it's probably better to add ENODATA to kernel::error::code instead of the helper.

> +#[derive(Clone, Copy)]
> +struct As5600Io(*mut i2c_client);
> +

You can replace the *mut i2c_client with an ARef<I2cClient>. The
kernel::impl_device_context_into_aref! macro is run on &I2cClient<Core>
so you can call ARef::from on dev instead of casting it to the raw pointer
to hold it.

Then it saves you from repeating a few different parts, like redoing unsafe impls,
recasting back to I2cClient<Core> in try_readN, etc.

> +impl IoCapable<u8> for As5600Io {}
> +impl IoCapable<u16> for As5600Io {}

None of the read_u16 or IoCapable<u16> are used at this point, so those traits/methods
could be dropped.

As a side note, in the most recent rust-next branch, there are a few changes with IoCapable
so maybe worth rebasing at some point to get those changes. IoCapable isn't a marker trait
anymore so I get compile errors trying to rebase there.

> +#[pin_data]
> +struct As5600Priv<T> {
> +    #[pin]
> +    io_lock: Mutex<As5600HwState<T>>,
> +    channels: KBox<[iio_chan_spec; 1]>,
> +}
> +
> +/// Encapsulates the I/O interface and its runtime health state.
> +///
> +/// This prevents operations on a known-dead bus (Circuit Breaker pattern).
> +struct As5600HwState<T> {
> +    io: T,
> +    state: DeviceState,
> +}

Could As5600Priv/HwState hold the As5600Io directly instead of a generic T?
As5600Priv was not generic over T in v2, and since As5600Io implements Io/IoCapable
and the sensor only uses the I2C bus it doesn't seem like it needs to be generic,
at least at the moment.

> +impl<T: Io + IoCapable<u8> + Unpin> IioDriver for As5600Priv<T> {
> +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
> +        match mask {
> +            // IIO_CHAN_INFO_RAW — read the 12-bit raw angle value.
> +            m if m == iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize => {

Ideally in the future, the iio_chan_info_enum_* variants can be wrapped in an Rust
enum with an #[repr] attribute. At this stage, match isn't as useful as it could be
since you still need to call "if m == ...".

Sent using hkml (https://github.com/sjp38/hackermail)

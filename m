Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793D3B71DD
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104483; cv=none; b=qVvivd8LjSfFH5qTSdcKRsQPaNEs2Ft/JLxXyuNpIy34jF8+jUAMPHEKvJ1jYy2p9K1CH0jqE8iBozrvc3riuWGZ7kNcnBH+aBzXYUKfYkj0oK9rBBB26gxUmir2H95L60KFGDNYYyOwKrlmuVqXPwrsZS7VJU58USHzDbhA/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104483; c=relaxed/simple;
	bh=PjGV4Jk66b8cMrt+IX6LqNDWzzIRRf0S0sfwVy3VWs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBMRn8iYkANTit9kHjlg+21QLGsKBEKAFMSE1klZWtAp7CIutGkMa26WmU0ngbHW1C3szK2HIg8yA0aDK3SOzRHg7UNnU0pGhCp0xey8TetBrCVhjh2lUBvZOW+IeMy38De5GJfkJr20Ypg3xXWEzejMHMNuk2H4iJrM7LrNRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMQFhgnm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMQFhgnm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436251906so676066f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788104480; x=1788709280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VP78R9nLvzYZIJLFwPGinwgsl4vkolB7rEthwCZKiSk=;
        b=eMQFhgnmpvdEzuQwHhkNGoEEoVcQ6mt8EO6DMgJ/OjzQJY7XVmQh8xo5E6LvOpFxhV
         ygSxn0Q/up17ndX7bm7Tm2Fub2jhujFU7dHPd3OMlMcpETjl9jbK3zViWomwNsTplFYk
         wzpK2UT/ygoE0ozVGOyCCeRcqCleRg1loTtcC0G0wV625V3qimux8207A7IFb2YkQXp7
         9b7S7zW6q65UpPiKOyjwm3AbAkis+k3ZjDpYS7Ks+PanV0blIwZpUenFIiD2+9nO/cSW
         2dQP74q0OzHzobnHc5oN5aUKc/9GGCK/3tMY8MNZXYQyzD8KZ6y02rXFgkytLNVVSDFS
         RgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788104480; x=1788709280;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VP78R9nLvzYZIJLFwPGinwgsl4vkolB7rEthwCZKiSk=;
        b=HQ/b+2el1li+3TpUukUNRWfBuP+eg/XRbWKKZvb2ZLSv1FLcuMhCktrNXVPoH5aq3g
         29HiNQAyZmJ77xKTwVOkIevpJYYTksgIZl51Y2kgfkfcCeLzhB/z6vfl9g2Hq+n3Prn5
         pDsw17fIDnBAVdxufPgZpYFm/1HaIipYMk3zGIFi4+hHoXrRmy0GKPgPIhx9vLJOKqyO
         aOUxxELTSku4lbBoDUlBVd1sgv4CqFW938us5G7Zie4aE4b7JSodM4mvTiQxwxSU7+MP
         nB6aH7hwYQWOwHdI3D9fbzZgE/XFXYNmzGUQr8jWOG+NTpZX+IAYjIOwDthgW84Hkzmz
         iu6A==
X-Forwarded-Encrypted: i=1; AKwUvBwbuQakurvOujpJUy9Geo7kWx8fZRDRmT4D979uYi3NiF/7VFkN7Wtl1RVl1q+Vcw+WvpL4rAbLsVo=@vger.kernel.org
X-Gm-Message-State: AFuF++k73wKyMhpuocv+VujUecYIHjiFrMa+3rFsG7H9Rwwro8mhwyaR
	ZCKGM5r89PghY/wAr8UiV88Hgncw4gygLjDDyUuvCfI4nut+nYjGo14/
X-Gm-Gg: AYBFou1f5tB/2Uign5p4gKYX8rEihYodmcQBav1Yk1kMwP4TJruO36E/EOVkf5dnLyE
	2BZOlHBM0ma40Epiyzhezf7NsUqCb3Ggh3pmH/daOahUb2dfTrhIqzyAkEXG7mPe2hXWc1JVlV0
	qQkYHQBpvIPo9w0TYcZyP016r2AzKla7tZRBKa/HpYXQKenpdY6yUw82JOofNkRUmndqwtwYjEN
	ZYLysYoqfnXFDm9SpwpNV374a+B5kiXM/MEr8hHos0nOApx7L2imLQq9270f2CIqafkQBnzts/v
	T4D6Nh5lj8zDXbhP51rOKxnf/fHk10BkSGv8XG25BYyyz/BJ3HH6KY0405LvC0732kTXXZjhZYI
	LCcETa8RoGZi8fHCN3aQpcoU4jhmb9hjEM8Ly26knjw4ORP5kArCARpsXI+NAE9MHRZ87twgxgM
	eed3w8q/vBi1EwmvS+ud9w6u38kpRCQAk3kCRjYYVnQ639CrOHz4Jf+2fiMLZkutPFtL6zHG5HH
	WGdMKdRbQbf5h52oaWJAR+k94i/Z4lj6G90lSOsksdoC/zX6aADEFpYM1/XCWKD4VQCNdHgZp89
	CNLLBIpoXQCdZEiQwyLpfr9lXk/EYamajM7vEXFc4xYpUtaXNERN4i1CEr2sutXwdN5cBrtey0p
	lt4Eg9e4iJIazsSoa0ETrNA==
X-Received: by 2002:a05:6000:230a:b0:484:36c1:2881 with SMTP id ffacd0b85a97d-48436c12978mr8886652f8f.2.1788104480124;
        Sun, 30 Aug 2026 08:41:20 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac8e61sm16507294f8f.13.2026.08.30.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 08:41:20 -0700 (PDT)
Date: Sun, 30 Aug 2026 17:41:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4000: use sysfs_emit() for near_level
Message-ID: <20260830174116.36fccbdb@systembl0wer>
In-Reply-To: <20260830054237.2147950-1-donggeunyoo.kernel@gmail.com>
References: <20260830054237.2147950-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 14:42:36 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> Use sysfs_emit() instead of sprintf() for writing to the sysfs
> output buffer. sysfs_emit() is aware of the buffer's PAGE_SIZE
> limit and is the preferred helper for sysfs callbacks.
> 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
>  drivers/iio/light/vcnl4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 336468d59ea7..dac235dd6220 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1504,7 +1504,7 @@ static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
>  {
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%u\n", data->near_level);
> +	return sysfs_emit(buf, "%u\n", data->near_level);

You should also include <linux/sysfs.h>.

-- 
Kind regards,
Joshua Crofts

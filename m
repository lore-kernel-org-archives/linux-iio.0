Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38434FF79
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085569; cv=none; b=OCDSlBu7hTZ6qkOhgh8SoCBIy9LQLlfS2jMQjY5xbXmpyCvnBNO1zWud2iWLi6mn7S+klKi065rmA435m8Jq5Ht9nrDVeZMeIQr7VjteKuBM5HlzffV4Hub9jS5o7tgEvR/vJAUBTrs91n1D5EDcXMT0ePe1t6v63uXCVGCnUJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085569; c=relaxed/simple;
	bh=mL/o0x8U5l45AtjSAUwiJf3Q6RsGlZhXHk/LiDnIUkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/rzBDeJXu654IlNuSIk7h4ErQCRHbNvIbdKlOWdhVJ9JKvBzQEvwlnOHHgNHusO8H6UtJjM0hb5recO/iTtXWKMsQe57oXsLY4qCbcwjyBPeSupHdjz74MCeKOBq4YvAn/rye4ld675QdMYNH/rm0Qavh0K/tm+YbGjXwA8FFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS2t+hZS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS2t+hZS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso2660865e9.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783085567; x=1783690367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6o3nvG+bVMICGNeP3rVUt3G2YvmvxJsmSJK/j+DjHg=;
        b=NS2t+hZSVU2AG0vmWnXlP1NQx9MKb6RmUgLbVesYEntb2eCLsief7RsVOS0sCXmaSZ
         lmeixPxux+8zp8QfJkiyV2HHulbq1lvy20qozbAO4lUYz3y6LPQud1wtOHU0eRYRa8xS
         +fPzt1JfyuP4O3zQLMcFSLxXMxwu37p40CzqbSRziKYnXVKh2K6TYBumOZb6GPlRIrnC
         /KqQOKIqMPiljP8Hb1DvfXkRcO1bi/fCmIt8YLC793cJ1k/evdso+cFVg3/fdgf4u8T6
         PA/7vQ0Id/Xxx7J3tjjwRUHHZa1EPHP+LgEBnaDstDiOCpMVu5MUGUi+jb7mP1w3IVfA
         Zg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085567; x=1783690367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O6o3nvG+bVMICGNeP3rVUt3G2YvmvxJsmSJK/j+DjHg=;
        b=j7OaYuJ8ikJdVY3e30kMWxryPUTIQgIuX8dOM3ki60yF6+akDD9SrrE7EC+E1e1fFh
         kmqOccTQe02X3ktT42b00lNt1yCam2OiTYZjF6GialspwRojEuTiabFOyoqhpngFoOCQ
         7tprpbDa0JWbMVM/oo8kbuhdt1qr4rdjQIBaowvKnLsGwKOihZujz6IzXvO4R8VApP/5
         gbXZAV+UUW1HkonDXMYV693hQgEhzp4sdViKuafyARYOAfcqkO4WeCx031U2EoKZiqe+
         k8Km88P/LSkX2kYaMy+o5+EQ+0F7QP1+T5/Bn2WEUPDKgXuoOYClIT9TGQMQXedjfOUR
         N+Ww==
X-Forwarded-Encrypted: i=1; AFNElJ//sUuKbKkc+OErrLvezebZJCnJQokzu2qY4qpwDJbskv+NKgbRSF5jW7GJLFtAZ9Ng5cQ8Y1xLq3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlPWJULimcZwuMGIW9p2YurMgZvPxU9bNw7TfzxBzxNGAJXwA
	oLfC4ca1zeJM7S/S+OE/F6X1WHTTsd2VzJKesGICH8t9xmlDCsVCyFQc
X-Gm-Gg: AfdE7cnMXPKd+eL+DH4eYNG0AhTOp7gSWNfmogpTIEfvGlqEWX9nMvqoKa2CeSE9LIo
	7fH/09WmZGr4LmtCaPx2AwK7AJ8JqO0e4ckZSV7crFFpJYz+S2z1qo/Gm93WNzAQGZbe/1UMrB7
	2NG8MnlzdP+4apO/HJv5XGyfsI6L/BzpGQA0F7gK8w0xiPTdaEbpgH+lxwcJc6NC6TPyvOJM6Jk
	UEeZqJ3PoutOrpjWtEVaw48p3xdcLHzPGmuNekXlpPBfsgDUveV+IZga7THwPL7RmP+5cSUEh8y
	CX2welE54YuC1yNvc6DoevExgFyXlGjFinX8D90ZZEIBtA2H7NZ9wunMf+sRX8VyGYzHGHKHD+4
	5ltd+ygYXKlXqvdC3J3q7NGKjmS8LCoRU7dySeeSjDVWw4EDwghQR46AllP/D46WFJ2pzWuIOD/
	rJG11v8jzWUVHDCd0GgkUJR3bPc9HIlR+PfsEdHRbXtueAwoVIKdjqWt1coVnoUf9RJ0ScpU4CX
	SN6xG6cZ37zaR/aK9QZXnsrNJLauOH0uNwJ2OOTNkbAnELenEpRAF1Lxd6FiqSQP64DgBC9cIXV
	HJuudsujmV4ljngbvuLDxS1MiABWaJQCbmoafqA8Bli7uDpCLBWL+ew=
X-Received: by 2002:a05:600c:810b:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493c2b99c43mr133479105e9.32.1783085566601;
        Fri, 03 Jul 2026 06:32:46 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm153127035e9.15.2026.07.03.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:32:46 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:32:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mert Seftali <mertsftl@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
Message-ID: <20260703153245.00001d9e@gmail.com>
In-Reply-To: <20260703130750.66549-1-mertseftali@web.de>
References: <20260703130750.66549-1-mertseftali@web.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jul 2026 15:07:50 +0200
Mert Seftali <mertsftl@gmail.com> wrote:
>  struct dmard09_data {
>  	struct i2c_client *client;
>  };
> @@ -79,6 +82,10 @@ static int dmard09_read_raw(struct iio_dev *indio_dev,
>  		*val = accel;
>  
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = DMARD09_SCALE_NANO;

Add a blank line here - same as the previous case.

> +		return IIO_VAL_INT_PLUS_NANO;
>  	default:
>  		return -EINVAL;
>  	}



-- 
Kind regards

CJD

Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EF41DEF1
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097536; cv=none; b=ccYjn6VwFYKKh8YDzgcGr6ZC8+NXoIwzSNYysjvI2q278UvkWofI+N2hOec1mExADJ1L7+75ZIjpWU9P/KzZz7OCvjYbOTpR6u7GCizrJv7FDnqhAUbd5/luFkFe/RplrwkHELPO84GoCDXlf5F2QVCnKLmNNv8T7T9R5fU8F40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097536; c=relaxed/simple;
	bh=oTHqQLCwhxCe7N0D1T5nZxG+I/w2kOY6Qan/KcU9ovA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gqpc70d7IvenHN4s2/jyFYwAFkKe+KEshuikkC+k1+fimT9OcUWeMXO2CWF+LglnN1gsnYhs+y0nZllzE89r39j/3hun+Kl/+EBpR6Qe9/BvUiFYXKKJrumEAOTpR+bpdOkJ0o8NifxzVoiXYRiSvyss9crxpsxGotWQ9wXvmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDwo4pM6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDwo4pM6"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3015662f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097532; x=1786702332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dysWOlTH9FYoN0EEYHBpje7XGNqqwHjlQuHDF1F6Br8=;
        b=oDwo4pM6lsDkvlR/EwiIIvye+BjBxsJ6uMszIagSAvhoOgbDiP72+P8E7pkkugWxbF
         xFZ5Ju9bE9lCiUvKFEx0o5fLMz4qPypgsTPC9joQQeGQ+cpnJdnCbDeg9f+xsjrpV9Ff
         0TdGViVNS7W2Y2Jy1drXsgJLRTHinY/oL7Z8o7JsjDfBlltFbatExSOVYqQMUamyutqx
         MSpekDzZvZqqjstzTdpChmyLlIEvMBGRtLHF0nqr9E8e3a8Qs2VmVRXZSWpx1OtemZbW
         mJ/7L+bWYiCUFkIMCrIrOTP/GzsMnoeaUicz9aSJ3mMbMDRIFIue9B/S1f/9256GGKE/
         G19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097532; x=1786702332;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dysWOlTH9FYoN0EEYHBpje7XGNqqwHjlQuHDF1F6Br8=;
        b=Qop4ECBBuVBLMvDFdhEnMTTCepApAEBEDW23a6MM02aU58cmOVsyEBG2tg+Tjhgy0b
         jbYsXQlAZsjVHZ077+TZWMqIhbcHoTjquFQnry+3ydIzBKkHpbZ0Q2yN2YzOlMLB497w
         xZzU/GszIvFFoy7ITfMtEegHWtkE4OEDIn+5GoxXW+ShjwuhTq9G3j8CzHZV8STsJQGd
         KAHDAAyjPQpubTkuI0SeELYBpAcnyeNWLYbGp7EmztldZG0SPY5s020MvoWa8qIkj7xg
         Ip5NDtb08pEfQXUtQ65KVSdOCvLk3YOtt+Wfz38Bk/g+7JL2lu1rme2hCc2mqF6OMmMV
         TdaA==
X-Forwarded-Encrypted: i=1; AHgh+RoHfCUKz33kD8mRFK/Jw5OlUhFFAhuGyP1lRyR8vOe+bkPBzkHPF8+pGdbg5YExs3ocYqz08yd8OAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUXUjvlecVe3CTTFIQaFbl12+zdikjUJricIqqHZ8a9+7d/F3
	kUjF9apwbrzwIyUj9KXVDLnSGXMqKvNBx8DVPU2XC1GNbKen5H51Hepn
X-Gm-Gg: AR+sD11kKHVUh43GCXGr7VIDNxI42DbGbg0E6+RWk+J0o9BpuKGw3x4ncNSHjx2KDO6
	RVS3Xck6dZkRu7npl3BsEkd6uPvKNw0zNlCX5cCGpOtuWg7mMCWeM6ylMf5oMOCX1atou2vxmb2
	N7P89XRRLQvJOU8KqJtakoVzXk6yk6Dn0bztZLa0U1b1rnyvVbjcmgyqXeHk7sVpjXz5faBKoUx
	iIE0lVQXuXnS3Ai9mTGVdj/YNe1SUIbz3WXvKLHQoeaRbCAobtdowGA8jMgIdtPuxQPetKLgv9F
	z8vx/2ernOFDpWaCLLpWIqfJCeatGkK28fldGzspTwKVEl/WHF+p5Sv1UmTTfO/dIRi0K2PHATl
	ocoR375CeFBSsn3aQrOwzTSUSzz5msac7472bjSlESM0VVSKB5GNf9X1WA/uxyI6kesF/9nDdzk
	rkMsV4xwBgCPGZ8ChYb+8aPfuF3iWy11Yx6cOOF+aQzR+Kfkbc+2SuT2ZR34VYfH15g9VRnOOfv
	VC5ja5P5/HO4JalC5hFno25+ddr5NwcUDscvSQBcUWhgAqTuqR5TcqWlSfv9n8oSJs51ZMT1TXq
	8UNoTt9WjUSrK6004tUq23c9sapJovSryn/B9ollziZUcpe2t6b9e1PmK1Y3vANxufHoakLN3xU
	6tzx3cmHf/5GJQktdXJtp7IAsKJasLwpmNtSznT7dXzG65owXKlaUx1WSCq4FXs7Tpyc50Ik=
X-Received: by 2002:a5d:64ce:0:b0:47f:e4e3:d85f with SMTP id ffacd0b85a97d-47ffd9180e2mr14145937f8f.17.1786097532403;
        Fri, 07 Aug 2026 03:12:12 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm4153583f8f.32.2026.08.07.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:12:12 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:12:10 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: andriy.shevchenko@intel.com, jic23@kernel.org, dlechner@baylibre.com,
 andy@kernel.org, nuno.sa@analog.com, gregkh@linuxfoundation.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: frequency: ad9832/ad9834: add comment
 explaining do_div usage
Message-ID: <20260807121210.0000764e@gmail.com>
In-Reply-To: <20260807094704.5371-1-raizudeen.kerneldev@gmail.com>
References: <20260807094704.5371-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 15:17:03 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> Previous attempts to change do_div() to div64_ul were rejected because
> mclk will always fit within 32 fits for this hardware, making do_div()
> safe to use.
> 
> However, Coccinelle continues to flag this as a false positive. To
> prevent future developers from submitting unnecessary fixes, add a
> comment explaining why do_div() is intentionally kept.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---

Fine now.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts

Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90234437101
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786399090; cv=none; b=oEBDxxRrBziifCTaDBieDvSX9VA5dR8vlOeiiQ3NtrgMPOqsF/vpLPF/NZP2muOZ080oeSH4gA4OXNLMxBxYjQFrJ1Na0SdGr5TR/mFcr61B9psL7r2hFA3aKPqPXfaky+5PoVNtkV6RE8K+ucS/KszWd8Vhfx0MwVRSlYJZHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786399090; c=relaxed/simple;
	bh=FZ+/71kynJZqIhRLVCnpGq9DzPUvEW+6dLYoLNMlYPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGk8IXd+xn/5D2aTC1enK9VznPmRzCcWoAD4dqMBpEZlwAOKU6IW30ZSlJ/5Gq6FGf/qqXnlwu1gnzcI+9fxOfsjPEIQlC1dR8/K49Pd1FqZcqRXKbHER13ej2cKGrhYzLcPKCbGg/Y4E0SCupt0XwxlCpw7lkUnOtFNksw1uE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3gX9Dz4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3gX9Dz4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3115480b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786399089; x=1787003889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7bGIdvE0TviHkwGAKBCM6Lg6niDAldjBWkfqCqVxew=;
        b=S3gX9Dz4Pc1HKmDJ/pIFAotDBLY3uF1uhlnIto77UchCf5I+lCJs+iP+sLC/k3yoC7
         w2WbNwKBhsdP8lRc4dToplh8p/iOmwja1Adyfe2upglynyFnmpRNdlgX4M70sHAdDTqa
         i5loIJU+4LmiqBLvxkPNQlQ6JwHPs2kU6YIXbXAnfMJWkxNiEqJbxinyIF1pwa2y9kYL
         e2wRRwJDnsa7xwbzIumxAp5ABcuAjb4x1l90QSp9Q0NGxRlwFJ7cloZ8xzfSEkGI9vzD
         snxLRy6qAMlhyg8EAaA3FpinKk6GBNdyW27xgb728i6X2ozwIYnIbj/zaTTJ1ko89wdh
         ECCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786399089; x=1787003889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d7bGIdvE0TviHkwGAKBCM6Lg6niDAldjBWkfqCqVxew=;
        b=QKhnkiUC1TvhTBYReKQpUpt5G8L3HtXMeNEJN+2J8/pmH9zvDmkuwj5VPBOPgnJ86o
         DS/1feTls+Wh/gP1vHL68Js/XjbIxnW6FMyv46qDx55aMI0xFC2j+ixgXCLKPTPcaJDN
         EnfeSJm7QbQHZo1BxZFqE/FApo2MIBG8EL8ejc7OvhndG68VX6S/Ensw6j3LP/WR+8yb
         IW9ewSd4ajdtBaYgbMyM8ceMTnhTGJHsadZ7wyoGBcfF3zpnUTWDVgQkNIpx0hCN89Q/
         G+jAy/ixut4DKy2mQ9Eh++VBUqToFy5KfLfpZ8m3W6ylynYJrMNhhj/eubWi9M0FIJq6
         OGSg==
X-Forwarded-Encrypted: i=1; AHgh+RrXMWKr7Me6gGo5r9HGHG8oEMJsHtXOcDfjUy1R0bsTDss7ue778pJ9B6moIlJJICSMEjazg/aLQBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1JE6gNoWLdkaTbnmB9uiwymT8eQkh+Hx4Ls8n9R/wLS0CbpO
	ZKE2dC/vcvMMTjUDlgWTnWSRjp2sUwpPca8ZOI7Z4pBdJ+Yb6eLLv1jb
X-Gm-Gg: AR+sD13GyxRtN0n1JSe25Vk0omVRs9z7WqPodqHoqOgJSKyscannap7Xpyco0JtWKqb
	rUlkfxO1u0jNbni63gB5PkUXHu7gzH0DvJqYdieRevBite4LhtEvlcktMytrfH6H8p4yzq2sKl/
	L1R7Cjp8e+ArnuCG1KnnHA51OqITX8BsdW6x7mq4AaOIen0u+8Rywy7VW01bQbIFfMAmuaFKD14
	/3nsomIIQWYxeql91ELnl0yUKNZ2JqRNfpYskSTW5dPsI+waZlniux7ey2/WgY7iCPKkkz+UWQc
	fDgMsNZ6jCJAiXmFp9J7zuHkpuEQwoGem2ODaPw94sua8aB9/RCIyAJ2h67cDRNTn6qNgVsFU+X
	8B2HRFRqWw5mIu1GG95XrxZBNmxZFGWURaOyYE6QUiwDGf2ugf9gqVhQSynTDg3JS+T8LdrXSJp
	mqSjQy75fztOePw6V2B2woig1pbpseVTxOVReINPxTE47ukfuON/fBd6dmkuhK/cd4GPk7Scvms
	nJLnpVzcw==
X-Received: by 2002:a05:6a00:1150:b0:845:c5d5:3745 with SMTP id d2e1a72fcca58-84f5e10f964mr27414921b3a.34.1786399088547;
        Mon, 10 Aug 2026 14:58:08 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2402:8100:2aa2:1af5:b8c4:d4c2:cc72:1386])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38b7d9sm4508200a12.32.2026.08.10.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:58:07 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Date: Tue, 11 Aug 2026 03:28:00 +0530
Message-ID: <20260810215800.55944-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810001852.6afc2c2e@jic23-huawei>
References: <20260810001852.6afc2c2e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 10, 2026 at 12:00:05PM +0300, Andy Shevchenko wrote:
> > So what is going on here?
>
> AI slop?

No. I only intended to convert buffer to IIO_DECLARE_BUFFER_WITH_TS() and dont
want to mix it with the existing scan member. Really sorry for that i should 
have asked.

On Mon, Aug 10, 2026 at 12:18:52AM +0100, Jonathan Cameron wrote:
> Given the data alignment is fixed, if we were going to do this it would
> be clearer as
> struct {
> 	s16 chans[3]; //see later, I believe this should be __le16
> 	aligned_s64 timestamp;
> };
>
> But that is very similar to the structure that follows immediately after
> this, but that has __le16 chans[]
>
> So what is going on here?
> ...
> The chan spec is little endian so the scan one is more correct.
>
> So I think the fix for this issue is move the scan element to the end of
> struct bmc150_accel_data and mark it with __aligned(IIO_DMA_MINALIGN);
>
> Then use that for both the bmc150_accel_trigger_handler() and
> __bmc150_accel_fifo_flush() paths.  A second fix will resolve the local
> buffer in __bmc150_accel_fifo_flush() that is being used for a bulk
> regmap transfer that may need a dma safe buffer.
>
> Please combine these two fixes (if you agree with my analysis) with a
> follow up to do the iio_push_to_buffers_with_ts() all in one series
> as they will be touching the same code.

Thanks, Jonathan.
I agree with your analysis.

On type, kept s16 because that was the originally used.
I'll keep __le16 and will merge buffer and scan together as you suggested.
Will move scan to the end with __aligned(IIO_DMA_MINALIGN) and use it for both
trigger handler and fifo flush.
A separate patch for the FIFO stack buffer and keep the
iio_push_to_buffers_with_ts() change in the same.

Yash Suthar

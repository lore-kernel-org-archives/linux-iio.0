Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78242139C9
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874769; cv=none; b=kVvmgdv8OvIwOV0oYfkEbr/EuhkUVmYoCLFZqQcZV51xlq7ipaIFBhAsTTBfAbehe3PJeAxTTkIAIZSO/2R7wZpCGZn0RMT2lr3yiX6Pn5RNrdXfmwMQNqSwtiQL+KCjozTrkejbDYWQC0IaO99LeFB6MVuE1kETXyH0O8nGfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874769; c=relaxed/simple;
	bh=WTqbqPq37rKweOHKu54gKVnSmegM0KIJTnWLBGOZpTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMpN3F07ANdaOy8KS14fVMtc0HLmG1jnOi3C0LwowZu9scQypH4ZwPkVBcjrvdo9Z66TgKruMsGDb0lqujd8WlLjIh2Ie0WFMvzSy9s75QY9wztifK5aY2yHDFOeMJE0Jf7aaQN9/7Lpx2jQXUSmK/IzAXVnBQIegKC5adGDjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKbOISmG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKbOISmG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f75f7172so13037205e9.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783874765; x=1784479565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZELJQCDcf/zqo1tBNXHl/JtAY1rcstC6c7cMjydOGy4=;
        b=nKbOISmGj2mkYd0b6MTSjcL5RkrTbzQgrISi988ccYtK7sxK9ovHR0cNzyDv1nOVcw
         05J52dcEl7rpY8FWsccVPWYLgBpBLh2N6DH6PuAET6aIrKQSOjpS+M3KXAB+28STlLAL
         o1xuFScXmtbOcQoMCiDWQmWtrHmjAgDMvpqqhnCb+iIYly/PaLWC+sEXMDx9sKxCEdbq
         epSRu4QvefZE2Ow05ExypZsIJa0tJlTBQCmHNtF0tinroR6rdFCLfvkLbJh+i85GZ3Ti
         m5nArbUyDbij3PKaPvJ0Z9RMq31tt6pLlHwGXyzqT6e9yVVRstlSIt8C2wRnPXzDLif9
         SxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783874765; x=1784479565;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZELJQCDcf/zqo1tBNXHl/JtAY1rcstC6c7cMjydOGy4=;
        b=sksmPwB6/dtrGtEcvpjAgm0MemdNDIXS8Jaju64KTxxJ6XCBvaWH99OYiZX4SdDIXE
         1M8Q7MpOmNpx710XIVJkxI2Z7lFkWm1eXl0ry3xnHYg2agrVTNCgaO2IQkBi+0At0LQn
         R4wzX5gFYlhc77Cvb19Tz7DkRROOFS6BQ7S02xIGwJ+qHN0xjpW9t0KVY8crZdbpdlXA
         ElT3DnNqSFu0d8HQgvvJvUhaDcKjLas1jOw+HH5LXVeMzXl+BdXJJ1jYWtCKnqE2jxjU
         VpF11LHrYtQV6G+j6Utf6cmcDfU1msdQvmtV0Y2KPmQN2mlZ1CQA61SuKNws+fYeVd3+
         xlIA==
X-Forwarded-Encrypted: i=1; AHgh+RplQt9ofGabPrGrEIdSpQJha3NEiZRZ/phguvJypt3lisZmZqFBChb0GhtRZjeyih7vHEQ4yjF11ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycp896zNIMWtiWlRON5n4yZ5QRsdAdq0wyBLfVbhqO+B+Pea4S
	7cAtVuOGMxTTBp9pLH8lQN3hhutA4TZuag5Ycug+Fnw6whV00QDnnUua
X-Gm-Gg: AfdE7cn9CDYIzjbYNoJZzvvK69+4l0ssZwj2eeztHaZSVCk/SArErixsxKvKOr1cjzn
	W8Sv9zkcZbA7/b65Dmwylu/j/0dMt5T9B8N7PrvpKWUzq0UybPK0o7Qfwetb2NDwiFcKxHAYm4M
	ZKULhjoimtln4s1VTnIv2Kr/R/znfwqFr2IiDYG6K4ANH2Q69nXq2DwYLsIO3abXFI8sHb/1WF/
	WZpGRslitN51lOQpqhMtrHJ9cPITnbQNtdx5szC2jjZhnesMIUC1EFClaL5mtJMfLKGIPjJVaQc
	dWJSLlbSY6SVW5RX837WVHXLtnmt3nSDRYCnJTixNZfXyNl29v2uYnv2t+9Yt90KboTvJG+bq5R
	zQv3Y58LUnvmZ9TGz4+Dx6UZossHjhxDVEx3FrxJzazwggvrQR2g/EleVQYdghDV3MKX4sf3rjO
	FP/fnWc/Jc95J82VlRb0APu6xvvSILbX9bxFrN0j5BQEQiUVijIAklld3Id1Ewo6Nh4V1eo3C6N
	x47XCH3uAbi17NSF9vM7I7cOdxa3abRPeZ/x56UeyoONYPQw+n3M8JfJjttTw0j++il6mG5OpuI
	7pWbImjyxX1bG6kz9frrrmBd2DKPu4MxVvuRPVm3j1QxuHoT9h7jWWb11giZ
X-Received: by 2002:a05:600c:4e53:b0:493:f9ca:d6 with SMTP id 5b1f17b1804b1-493f9ca0569mr58979475e9.30.1783874765295;
        Sun, 12 Jul 2026 09:46:05 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm317349785e9.8.2026.07.12.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:46:05 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:46:02 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: dylanliu050903 <dylanliu050903@protonmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dylan Liu <pxyforeverlove1314@gmail.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: =?UTF-8?B?5Zue5aSN77ya?= Re: =?UTF-8?B?5Zue5aSN77ya?= Re:
 [PATCH] Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
Message-ID: <20260712184602.0c07aab0@systembl0wer>
In-Reply-To: <BKV7Mhbq1o3O_ErHy0kJsAxQU0wPO9BA6L-6CKJlZ9DsyAlGxNQzVfSIokpg-0V4bh0dp7KoAsq34iyjPsGOVDfFX3YSI7d0MozL381XqkA=@protonmail.com>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com>
	<2026071227-unspoiled-blatancy-0809@gregkh>
	<QNymfg8xEp8CU0BQxNJDcXKxDRN_xohHqySr8jzeakn2iJwHaezt4D2ks87ODGRh9227yPZ6dVpvcAa5OghRpS0htIaCUhCS7viUtr9aPgw=@protonmail.com>
	<alOtR-zUc71PORuA@ashevche-desk.local>
	<BKV7Mhbq1o3O_ErHy0kJsAxQU0wPO9BA6L-6CKJlZ9DsyAlGxNQzVfSIokpg-0V4bh0dp7KoAsq34iyjPsGOVDfFX3YSI7d0MozL381XqkA=@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 15:41:54 +0000
dylanliu050903 <dylanliu050903@protonmail.com> wrote:
> Hi Andy,
> 
> First, I apologize for the HTML email earlier. I have fixed my email client settings.I was using the ProtonMail web client instead of `git send-email`, which unexpectedly defaulted to HTML.
> 
> Regarding the ABI change: I made a classic beginner mistake. I changed it purely because the `checkpatch.pl` script threw a warning suggesting it should be in snake_case. I blindly followed the script's advice without realizing that I was modifying a user/kernel ABI. 
> 
> I now understand that ABI stability (and aligning with IIO maintainers for any necessary staging transitions) absolutely takes precedence over resolving style warnings.
> 
> Please drop this patch. I will be much more careful with checkpatch warnings involving exposed interfaces in the future.I will also dive deeper into the codebase to ensure my future commits provide real value.
> 
> Thank you for your time and the guidance!
> 
> Best regards,
> Dylan Liu
> 

Hi Dylan,

Please wrap your email body to 72 characters per line, as you would
with a commit message. It's easier to read.

Thanks!

-- 
Kind regards

CJD

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0333C10AD
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968939; cv=none; b=Fum90UhEYxZBIhmPngISqEV1/E6CyFPO1qtgkVfJleolx2tCzzgDuHkQxNaMtqxVGXlZuhTriS0AlmkUH9QE523mGXMC5jyy5opk3sbyiMg5CKn0AZtlytcQeRG8GJYo70wFYEN/2qJMXs6BVj3MCX2V5Q6iq1PMwQugwXV7g+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968939; c=relaxed/simple;
	bh=6jLJPnSoCH/mH1Zyz/sV3MyuC0MxAK9l5WWQyJeyzFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa/APGqo0AJdc6shpxWVqfmIbT8C3rbwlyTTPIFkrdnmVRTgk8iKMogRNWjEaecLc5j6LHZBK9iHoHM4fWwd4UlPFeFqyTEUhvUId1eS9T2MgWEzi5zt30dq3NovuSDq41DU1KjhFiBAbMnqq/WCuqyBTUJfgcD4Ge+lBcQHcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7nu/ZWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7nu/ZWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91FE1F01558
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968937;
	bh=6jLJPnSoCH/mH1Zyz/sV3MyuC0MxAK9l5WWQyJeyzFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D7nu/ZWbBeQSUDyb3arvbMUxNrzgk1pZ8qJPf3wxV4KJFmerhwXXyGhlm70I6IF4i
	 vSgyFAXmxVHDPliRNwxNVJGI8Iku9wIX4L/X3xYoMKplWTgaoTyzfiWwq2kiPKndW4
	 dI8DjvBFmv4fV2bBu5tFwdV2P+uSjMQPlTBSHM6EVphgwAhESAG7n11J8YGWwBE2Db
	 +ybb4xzIxlqJHfHf9GTpCIMBxTfIF7m3qU/LT0nN5kdVyz+BpIE53xak+9F8IBRuDW
	 c5349wNJ8ktTkZmhNlsr5B/ECFP+mkjxZMOJLho/+QyehQcMNzL5eik2XQv2AWKnLq
	 6/Kz/u8NsvoBg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b45f1cd80eso2284844e87.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:15:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp3zsy1zu3xo33IAua/IVA9wgW/D81L+QearEZcs8YlPQWAEaSrP9XxXYCxrAFdoNGb5gnsbAPwvbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8exkgSpME/JTaE7RYkeDDXLo2l2pNAAjILsn/sckwLyyaSWg
	iFgaej5S7W1Sc68Ot4n1uw4TolhsXxQjl60NNHaGc33vHhrWVMi8hKjvU02abEKbl7KhFrSWF4s
	XBT4Q5l3AD0riaqmxKBY8wst/4wwmwT4=
X-Received: by 2002:a05:6512:a8b:b0:5b4:47d7:38bb with SMTP id
 2adb3069b0e04-5b4591497ecmr4108102e87.49.1786968936456; Mon, 17 Aug 2026
 05:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815175728.99541-1-yashsuthar983@gmail.com> <20260815175728.99541-3-yashsuthar983@gmail.com>
In-Reply-To: <20260815175728.99541-3-yashsuthar983@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:15:24 +0200
X-Gmail-Original-Message-ID: <CAD++jLk9XVXMH9B8E=o+yDckttxW8uG-NTmrMX5DR=UNB07mbQ@mail.gmail.com>
X-Gm-Features: AcwNN1Wawbfq-BIQyglkrVSEFKItWPB7gTVxE6sJWdkhmlMUCAAb-b1tH-xAPG4
Message-ID: <CAD++jLk9XVXMH9B8E=o+yDckttxW8uG-NTmrMX5DR=UNB07mbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: accel: bmc150: use DMA-safe buffers for
 regmap bulk reads
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, andriy.shevchenko@intel.com, grondon@gmail.com, 
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com, 
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 7:57=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.co=
m> wrote:

> The FIFO and read_raw buffers are passed to regmap bulk/raw reads
> ,which is not DMA-safe.Moved them into struct bmc150_accel_data
> after scan, each aligned to IIO_DMA_MINALIGN.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

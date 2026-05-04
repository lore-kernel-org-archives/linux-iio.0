Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0783AA1AE
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894404; cv=pass; b=Avg+NN2ph7U4lXorSG9oc/KhWLStyAcs59IKCWB/o35TO7Zw5cHWOuK2ZU1nrE0BmZnVg6Wg6bs9ojZGpBosuWQIsLeGiH+BF39MVcH98mZFodKsUMmF1ZXTaEigveuJy3BqGMz94PCcqnVj7B6QGkmQbBUyD2138x7y+lPS9is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894404; c=relaxed/simple;
	bh=Gm4bad3ljN9rzaQgAv5nPfQJAhwBS8Yajw3wQMCvYs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGJxY4L6NVDmVMeag0cIyw18IzPC5oDEdttbfQ2jMV+35ZdlsKArzEzINsvzr90SmF8ZVAm4KNAQwEQQfqtn5cGX/NawndJrEGATw/iINuvmCf+9QUGsuriHClV0613lhLZRipKuZgWtDFCprhzU7Vn4uu+iUq3vjDDlNVBqydU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8tMPCPa; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8tMPCPa"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so401968f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 04:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777894402; cv=none;
        d=google.com; s=arc-20240605;
        b=bO4l2CslrFfkTxrCcsRTjnaFMdqvxKyhpznmVPEXWXwrr8h61GmhDdlFZ1V4LB6Q/C
         Ubf+pkUbLVA+i59d2gnCzMENcFt8o9whaiH0iT7t0NHtzGGw/RR6VO37KfkwEYpBDu3q
         lf20p55ihlNcjx31O8hQek6/T37o0/H/ep453B8O5mjacfZ3a4zq0r67Vp/UchJjUOJ4
         dPveSCf/+lGp9rjod3MVcNbJJx0B+tB07ZFfA+Ie8XDC5XbTLa3HZwqjrAzLuSU8TayU
         6ZBcaTikTnmNYjoF+bSffkqrDOdi8QwUxHOpVpQE50LYRVHnpTp84uKo2bmdz2kCp/K8
         V7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJMSUJnOSGLvSA3PGFQ5YaLyEaFn40SRqAWGrzUC+EU=;
        fh=vintpoNTOskY/JZx4ZYifz5XJzSNWgddTYPpTfDvI0o=;
        b=Y3ov0eY6TI5DvNAYkaHpH4wmjsBQvNGb6o76j6ee2BTEmcSUZMlQ0kAB0Z5fKJbbPJ
         IXIPCekwIlcJ/T16H1KA/sQYIGjTUQsKQGlGq03mGCI57CLeBeTqvEYtdVB0C2Gn3fWC
         JvNiqwRmpI6eTBQAPEyEbDnsT+NedWoYfCU2tBhtaDOb2CcZNkzmHB+lM7jcaBAi0/1A
         jBPAa7p+RQjYvqyo1NzCIF+0VI3zhcoYaoHF7syY3AoDo8KnLx27AUn/x0Gl/ovr56eJ
         MaSeZ6N0DB2tmzIWPKtHaJrpdZpMPa+st20xff82XOSw0F4+AGfC9+CAbpYDf+GILXeW
         RNMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777894402; x=1778499202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJMSUJnOSGLvSA3PGFQ5YaLyEaFn40SRqAWGrzUC+EU=;
        b=H8tMPCPaJFkHgTuygb4QHSIs9wsG3zxtPwAMVD1EGmRwv/kA0nyV+B1EvDd6YkH6i3
         1W+p+N8FNj2gf/C0HM6xfKN+bcm/3cFgWc0bWAj0kPE9s/7voHMMPeefuUfinos2krr1
         nUU8MFWnHPc0D4or5XLWhIvnMD5jwV9ffeE5OgNv/1GKoczn+OIlVV2QQiDRY76eVxn7
         r6mnZWYRWMVd2+AFh4qP7hJXg53wx2nHYhoaets5rbeoARkbudJN1FIyo0cJX+aoILaI
         NtWIrf0E3zyfmizwt87cVbw3xTS9lmj/aEAdJeVmClC1idNd3VXBR+jxkdZZ2kRnccoV
         YVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894402; x=1778499202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJMSUJnOSGLvSA3PGFQ5YaLyEaFn40SRqAWGrzUC+EU=;
        b=icZ6wJYSLuZo3X8iGzxlFI3nYCdl9BmPJQ+XtOiW5/FJ5QbqObdw7bTOv7UirqkxM6
         5lZQc2Edjyz4e4GvBNrxwAIYl0gKUNrQzvQUGuylpied+QL4BGh44HMs1hYNhxEtyvOg
         6cDWTiD2OG1XmBcz9HZYc38uZrXciY1/1uXadgffTOh3FiytpX0epGKeeQ1+ufgl+IZQ
         4hsOjUaG89C/tj4ftLfti7vyj6j4jzUMk91djTbkDv9nMSEqQvdwWq62HBGnWbafGPEY
         NRxjypVhYlMwUoKuY//0gpelGixRNcfoIgUUTnpls3qTf4WQHUIlqZXdOfZHmA2J43y3
         IG6g==
X-Forwarded-Encrypted: i=1; AFNElJ9q4KAfGnPs/2bzRho/Bd0aTxQAcqGchE4E81++SHU5KhfTq8vllbcCt7a5i3swzEHenVhAvmMMj1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGFYiiUAIrJFpPK8SqggSqL2W7+1Ckw1YSAO3fYlZ3X374Ux2
	qmfuVjHa6lolPblEU/3Zaw4GFSOW8PrVEsvJelb9BiE2t97FcXGO18VmeB0WjHN1LZXLfuNIH96
	uAF0cZdrc/oIPmlEUeZGHe2TVKz+SjZU=
X-Gm-Gg: AeBDievwUUjLLrNt7CxEmZxkMlTo+vYhlOWULymUS3DyxOGUYHLcK/91rska9XnmwVV
	AcSvVEL9zOaNeM5KMIQ976jxWXr3ZxCtmeZtFBiqAZKR6AZ6S9lQMT56NQPYVUK26rfPPtlMDBB
	rUH+d6c9qkzpQt4X0bYQcPjpqDiot0VOkzN9L5RYv3IYjAPROdAB2okHhyxfVXcn+BwMbM30F5w
	W7Rp7rqGDTQWLQhz5ZjtKapD/8UaEsInnhusdRDHFwtaz02hoeuGxtGKYdtR1u+FURbMBDwl0zR
	zd4Ig2urzzxG5Yu7ZoYPGm2RNmLT1seUIld2aQL1BQT95MHohBZzHdYdZMnSf60nkAAhh1KrATX
	NumtgDJE3W8NT1i6l4B3t+a5QOXd1o3htKWrQK14yEgw9E1qtcN3+HZYLL+Kz7v2PZ1sIRmjMPR
	X2R62jKIzEv02yrhmvgzHyncU+TzI=
X-Received: by 2002:a5d:5f56:0:b0:44a:b3c4:a044 with SMTP id
 ffacd0b85a97d-44bb68c793emr15677513f8f.30.1777894401585; Mon, 04 May 2026
 04:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com> <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 13:33:10 +0200
X-Gm-Features: AVHnY4KTNpb8gMFiT1RNnfrsKYwFo1Ix8BrrPZP6gb3F6bRdQMzkxzCCN-VMKX4
Message-ID: <CALoEA-wpqpT7iscVZScXduj1S02hVtz8AQCiKj-Aiz-5A0N7TA@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 11:48, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> @@ -708,6 +705,11 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
>  static int ak8975_start_read_axis(struct ak8975_data *data,
>                                   const struct i2c_client *client)
>  {
> +       int irq_timeout_ms = 100;
> +       int timeout_ms = 500;
> +       int poll_ms = 10;
> +       int ret;
> +
>         /* Set up the device for taking a sample. */
>         int ret = ak8975_set_mode(data, MODE_ONCE);

BTW, also noticed a redefinition error here.

-- 
Kind regards

CJD

Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A3625
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766529; cv=none; b=vFnYC+t7QOJZVEvCWtO53kSW4zpGNgQNneoy8zM/Hui6i2/XRMAt4VOflcd797N9xnqpyS/g0BF5ailuoxDmNW9lvVEVgY/kleqZFG3FY1URj6eNIUh97bIr1q9/SFQxlMTDbxn/yIpxz5JXJl+wBOsj2C23lxjqJxieUF11H0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766529; c=relaxed/simple;
	bh=pLQIBbI/WKY6QoHNdl2keSQpwbQLpGBEl47bv8UVCLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Ykd6ip4pC+wwatTUdTKUKEQkMP234iyGOnJFpa4BCKQggYmBGrYiB8+huWqFnP1C/o7sDReJrq84DNd+5ZEoXMXQ6fox/IPA+T6/HKjRaL2YR2tnD6aLMMLioRFV9r93UCY0kYn5vxqDHt5rxelS2NeXxmFN/1IfyNtwEPGuLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTllL4EY; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTllL4EY"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de4be15125so2682588a34.0
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766527; x=1778371327; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjH27Hv/11T5m6Ash6tUmNSwE/sE3YKWhfeembw+99A=;
        b=gTllL4EYyL68/rkVw6a/cy1kuNHA7jXem/Tp7TsEy4dXa1l6E6jvo2ELtSh+49Ax95
         b1r2nhnBHEaCmUpJYB9m/RcJQ5suVwGo8VPya5vCebAdly+Ymmc5Mev+DPNdhyMvrRit
         +wJhZSg6p+YSSNavego4KyQX07nBDqYJonJPqjhU4yegL3ABffEICBRl2JUhz1q5LXR+
         IP1vrngbbiQXOMH55UGF41mJkjqhlc7D5m5fYsiztbbwcUjZ9zc5wHxITZLjYTqedzMj
         eazI34129icMVPlcDAD6PPePJ4XK0gtWg7zh2BQltKl46QyB86tKtzz1Yw5rVj2Vd4Ob
         qXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766527; x=1778371327;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjH27Hv/11T5m6Ash6tUmNSwE/sE3YKWhfeembw+99A=;
        b=L255R7o+ebL5uRm344QprksrU9id+34uSJcQISgyxN+TiPT7TPnrAf6Bww7CB77BEW
         DqZsj9yRRJ0cnmr5r9D1fLG8LUemJZsltWTwTpeG2KU6JEHAU7owQF0zGomKIXsB86h4
         Ch6oGntoP61v1xHSaI3fM3Ymf/TfDtLOEIdrvUQVX57pqv8XlBi3NA+n2O9wka0wzITc
         z6GN3qdk/ozKReFoW+3zv1qHqdOO1bG50NIkRHe9NNvI9yCl5s9bH6tlOTFbYurxJHQt
         Rdd8xKMAtgiUCmXHsUZWmJkKMBiwVwFzz5z90Eb2RHwihGNiby3XuwuR7hQY3JpKyWD9
         xxAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7ILnCgMO2FDCcpqKp/LmS0SEE7GKdYkzoH2esg9x56E5gXav9goyjS/1THpArWrH9kvbd6tVgbq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABkKBr/CzozKiKUYFqMbkiahTyJ3bUnPc9Z0Ziu8JxbC2ZdKC
	IFZYtAAkzFuS4YjVWJFJo/bKhAaNalcUp7Hczg2Za+rbyd/MGUMwppkd
X-Gm-Gg: AeBDietiY6Rb/uSwGCqYdD7HaDRNHJydCzwZDxwXGY+OJNjy0SaFCfLRL9Fk8FObfSc
	yIIXh1SItoEEhdXSQVct1Y0CGAfOrvsPtUidsB12KQNzY7rYvwjL9FM/RORod+zDl2CriAJb1m1
	AHTHYl+V4WCU0lMOA/CN6ddkSrQxBAK3Ad/rj8BnLnoueCmu0dpGLi19PIOZkkabIyDHtXWsoRO
	wle3HDuzJRgDQIYEthNHFupbz6win1R6OtZLhEP9/cfYji6tzUXjjgLlYfs8MT1RvuXCidme7km
	2Z0tvd19SNcHOw0p4fRJcsnx7l+3dP4SQZzL994I3ovCAHrY7m63QLxj5j4Z2hux1FWssfExs2l
	eBrx3+LKpHsWwl9eHCKVyox+tHpsyjYpJr8zIcMpYGDUJWs6zt5wdkL6jq4bJJB2J/QRU2t2VL5
	KeSWsJ5FxOEnWRBxIC2ypSW99sWFVr8Pf0W3AqaRoXbwEvgQ39UmWc+lVFzkNWTMk6EQXYQDI=
X-Received: by 2002:a05:6808:1797:b0:479:d467:1a26 with SMTP id 5614622812f47-47c8930bedcmr2479413b6e.43.1777766527403;
        Sat, 02 May 2026 17:02:07 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d324a4sm6572005fac.14.2026.05.02.17.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 17:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 May 2026 19:02:06 -0500
Message-Id: <DI8LMZHMMBVM.1O5Y8WSPHPM1O@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: veml6030: Generalize hw_init for
 veml6030 and veml6035
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Gabriel Braga Lagrotaria" <gabrielblo@ime.usp.br>, <andy@kernel.org>,
 <dlechner@baylibre.com>, <javier.carrasco.cruz@gmail.com>,
 <jic23@kernel.org>, <nuno.sa@analog.com>
Cc: <ricardo.kojo@ime.usp.br>, <elliancarlos@gmail.com>,
 <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
 <20260502234348.131563-3-gabrielblo@ime.usp.br>
In-Reply-To: <20260502234348.131563-3-gabrielblo@ime.usp.br>

Hi there,

On Sat May 2, 2026 at 6:41 PM CDT, Gabriel Braga Lagrotaria <gabrielblo@ime=
.usp.br> wrote:
> Modify veml6030_hw_init() function to deduplicate the setup logic
> for veml6030_hw_init() and veml6035_hw_init(), and remove
> veml6035_hw_init().
>
> Additionally, introduce struct veml6030_hw_init_config_desc to store and
> pass the custom configuration values specific to each device variation.
>
> Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
> Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
> Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 92 +++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 55 deletions(-)
>
[snip]

Just curious, how was this tested? It seems like you're modifying the
writing logic as well, and ordinarily patches like these don't get
merged unless properly tested. I haven't fully looked over it yet but I
just wanted some background before I start.

best regards,
maxwell

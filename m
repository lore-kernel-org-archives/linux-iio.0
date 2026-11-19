Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119370;
	b=YDHskCCWqNYAELno2oNZuL9OIG0yNKIak5TWjdUnjh41A9bOHVqtyok6hqdQR6vvpi9K
	 y+wAINTJrOnEKwiRr8XwBJG8WfkfFNIaHlm1Ax6prsWKePv1Y1weIdLKCK2I0wsfzgBTz
	 gxg6S6630q/CPYBUl39uz7W/tKCpvBlNUG71JqPxKTvT2+I3T0vkYOhk2Y87Ovx5EPTN0
	 jXV6EfjSFO1wNuLz4s9Q4blJ8xc0VScisllBvd9khMBR6o8mYYcrg9c0RMJiC9iZGFx0p
	 /garcJBS632SF8RotRWGRiuMQWYWUoofYAf7uaPaPNQ/+TmZIJtW1dNzVOSnkBkpgRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BJ0g8ayK585YBdUyNlE3GPGfog0BfUCB3VPSV5irDYk=;
	b=pSkXpauFOXTBivk5zqfHTJ42OKwUiWEhgdjWjIldcGPZee0FSWTZA1NmmR0cUsraOA8o
	 XRKTIUxvBWbyLpHDdUVnXBnpuhlhqlhIXUQEcO6nUCit5WK48PW+CxPiAtWQYJ2W/yC1A
	 4mDxF5ayODceqaFsRj5jfS9d0XBk5aDifVFW7W2KyflLv3eCDSy5Nhwv8u3Y8SfV0JJLj
	 xCo7v4Uvz/eMme3gIeE7sUyieMW8u5i1WdemjrufIJfaN/pmjAd6qimBPUe5eTiXGvu+3
	 JWz7N8r954Cv2j4w2+HtHgEUxrkC1BiPSeIGbmyXVBBmr/JtzCm5Xl+MXo56rKPGewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xw92R+KJ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C5606A326
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 20:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xw92R+KJ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-381f65e4e4bso163444eec.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795119369; x=1795724169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BJ0g8ayK585YBdUyNlE3GPGfog0BfUCB3VPSV5irDYk=;
        b=Xw92R+KJVi3ceoZYz0PNPqos9wHg+5uxbyM//hYgj5A5enob04m27DfaZ7RTK9lUsY
         d9AcecKSLYMDwCVZRrOxhKTSdJMobPrUQjGwSPXesOiwvn8F8kacYokh9c4HRrXP+1gq
         Zj+6z6lkR9mxxUmF8fxsm217u4cLWaMdC9uGZ24nYx1aQD643aL9eWoO9xz8Klom0zgJ
         TtKRb7JjjywXYFGk5QlD4sxYIrM8uxOMcGk4eotFjq1WkMg1E1jELqxNeyquOPKwSoH8
         tGpjtQTY+wsdy+sElai3agXVLQF8xjoyOi7fAgBkFUD9dpu0PM8pepccgLoIMO7q0Xtm
         9jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795119369; x=1795724169;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJ0g8ayK585YBdUyNlE3GPGfog0BfUCB3VPSV5irDYk=;
        b=yOZZmdvIadHi/gBJxy7TUhy1tqEUfQD87XF5mIGdRuLcRs0RIBogasWeNwOMGaOS25
         wQdHfap2Q+kh5XhbawAPXdEvnAnEeFoksR/vcJAJ+1UjNrgbPHnHsMsSFAk+w9u7bCEu
         W4n0C7J7wgTS4is1LczBqxDQ1HZ5dR11ut4rhJ6hqggyEKVEnmyGe5BSbBds8v5zQ9gV
         cbHa8L2CHcnDfjbQXOD+NUhOAhJiq5+lXvnnEMk+8mmFlHEbK9+++lPawQMyboZMt6Ji
         LS/mrooGoNU9y99OKKoVU++ca9hlyeG/APUd+qUQ3kFn5gUorH8vjW/6m4kVF0j0zn43
         +6Rg==
X-Forwarded-Encrypted: i=1; AL+hErHpHu3uGdHGGTVwUUpCfdHfAMnfHFYI76fFGc2wDJIdOKNKtHqItyKJ0ypv/g6YT5+fpge9dDO0VjY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ElOKNWKAB+edHB3vXpek+xj8vp/fdm2X4+Orps+/xzifIxoG7
	CyKsDpEkLOGi5+rLQq+kLugJ4xLguF6Q10utSrZhtpNO/D5g6Q+vpLrl
X-Gm-Gg: AZFdTZd0C0BOUfg+BnVAE3UrbX0ba0nHA0znJpB/GOgTak0Rh7u/bu1JFqqIx6Keblf
	RvYrI3wo//hax5wan3X1pwa1laqeEHcEdy5/bCk5XWoqZbHyVQiwo5WK2TqZr0wylKNDaBfqKkj
	Ha3x8WXcHPp/VYr69Bm04mj8I5E3d9HOXMCskmbSkqZ7C9kFNN8dOzE07mcq/AmXRyfAXHbg4m+
	pYeOCRrLLd3r0IZe5AA5frKxXPn8BuBmWN9PMc8R8KlK2e/Uy0qJccFKqWUOlnvl+q3ME4U6CEg
	mHKOTMLBRxyFvGQRptdXQMgrVhN58XgtZsbJEskgkJwU5SnBiQthzsEnhteBTh/ojZ1kBcsl8jY
	5t80Pytvhn1IxowPXya/oMcEuOGPOt1hYCVwbPrBj6Azk6uQlYCzL4pl3zJ7f+4MySBx8nt538a
	EJlJjPQj2yNxm6klenpqLqqqAx+B6RLI127wVI9Kt13fJ18AE35wZi8JpIRB8sfSDWYde4jLzlD
	10MjzE7edh44COXYW6shln6K06LNzOfCQrPBxLvrzKMzva7ovDR91L5IxePTMX/vuhzRu7AeAP6
	KB8+e5DxonfpxZ8WcF4r471IVa1C/jAmVCqX0mCYmh+eIl273Pp7GjugX/GBUTStv29rgUm5DiS
	PIBaAY1PklJgQ/A/mYl1JrIu/pz5CAEk+NySYN7suPZOyTwJtZmvR3ugj7dkGVZQZcl2e7DqY3a
	O0X3zU5AJHECKViosuBoPydTLxc8NUK4wP+aWnQsHOIw==
X-Received: by 2002:a05:7301:488d:b0:366:83dd:46f7 with SMTP id 5a478bee46e88-3856f85220amr398287eec.17.1795119368956;
        Thu, 19 Nov 2026 12:16:08 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm1164248eec.4.2026.11.19.12.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:16:08 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH] tools: iio: Prefer channel-specific scale and offset values
Date: Fri, 20 Nov 2026 01:46:02 +0530
Message-ID: <20261119201603.185301-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119133821.949-1-bhardwajhimanshu2515@gmail.com>
References: <20261119133821.949-1-bhardwajhimanshu2515@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 19, 2026 at 07:08:21PM +0530, Himanshu Bhardwaj wrote:
> iioutils_get_param_float() stops at the first directory entry matching
> either the channel-specific attribute or its generic counterpart. If
> the generic attribute is returned first, a more specific value is ignored.

I ran the old and new helper (built with -fsanitize=address) against
directories holding the MAX31855 values, with in_temp_scale and
in_temp_ambient_scale in both readdir orders. Before, the ambient scale
came back as 250 when the generic file was listed first; with the patch
it is 62.5 in both orders, the generic value is still used when there
is no specific file, and there are no leaks or double frees.

One small behaviour change, which I think is fine: when the specific
attribute exists but can't be parsed, the helper now returns an error
in both orders. Before, that depended on the directory order.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>

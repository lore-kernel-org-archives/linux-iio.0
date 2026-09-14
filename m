Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9348383B
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390168; cv=none; b=SUlnMd2vF/eDG12WxXPK4YBgVgpz3xLZAkqTbQz0oGgz+Opqciwr5b4dFjzSPRTMX7Mzf+bA1hX0dWn6uF4QNrF4qB5HlXg7rK6yRy26J9BINpmFnObdzjg9Lfl9T7GWrCLhOVJXgQAKD2n5qDro5mihyUk6oMyyitskdJPSJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390168; c=relaxed/simple;
	bh=aQYzR+IvQykSVUn7rBpK3rQlkN9oxeBGlmz382e3/mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFH9SjOq4mY8fr2HadPD6QQkqVQSkr1brBbWoH9Q+woXUg/llDSDeekuQdQqO1yi0KcDbPHAJw9aEVCJlRV7RvUi4wCAk1nzhsXzqpBIMnzc6xpIrea0jHkZm1RShkrJctzRON0RFj03+vzfIddo20D9bOnBzkJPAxVmXaPfoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9CnNKXI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9CnNKXI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so11209625e9.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390164; x=1789994964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Gq+pmsPFihIMk5W7k1MUPH9S4la2uIzpj309XLReH8=;
        b=D9CnNKXI5nHcsFda0H2dor77STypOKXJblNRUIaQ+aR7vU/2XWfxiXlJTvFSiFovhK
         zcfrX4vgpXvi5FPPBbP5nf8wIkQNKdpvkwQDrdxB5MCByApPWtPLKL56wXxBj/qaPLH5
         hITKlnQXw3x5rRvlnyPB2TDduN/ct0b9l44CAgVatnP224tZepwmFf6a4ajXdKD7tbqw
         mz4Eb9OM5NouWpbYG4VxNDsI3XtN2KfwjsP/2tPdoAS0KBofb8uxlClrIqv1s4mxnNR3
         Ji0chWYxUrg6phuLvUBmlEaKzhpets+/aQ3kK4K3iLu7RgBsjlluveR1asVBsWbtGL73
         Jw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390164; x=1789994964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Gq+pmsPFihIMk5W7k1MUPH9S4la2uIzpj309XLReH8=;
        b=JrkEnClmbcD5/uZFJKtKw5L771JFzawcc5DmojmcBsFXgx7Dws9oVXqrnvodxLJ4er
         ObvtLRvw4FKNsBDrWMVHnpyKpf+Z0tFp8hwfxqM7TivjwiXIVq6gmhW9zFXvkxD2tZtY
         OVfTtv1LCWu3xcLkXygDJy9a8LXoOQElJSqDEu7hGbYxGyAZwrZ4JIpaeH8aJOOZ9q3N
         eUvvFVWU4iF4yaaNB8vS6ZLtyfaFETiarQWF+5IPtRC/7K4c8VvvEhc2D+l7SYfyLW82
         CEYeFnFmzKL1A2WHOQR01cPJc58ZHVvGE7stfkkXwtx9N2fLGIeE0dJJVfRaDqcn3Cm6
         8x0w==
X-Forwarded-Encrypted: i=1; AKwUvBz1ExMWG3sEqfsDRj1U0xJA+Vp/IaMPk3aMkPJQY1Ozlrhjnr4+JJBWZ2Zm8iS3pmQ/W+eKTAMuxUk=@vger.kernel.org
X-Gm-Message-State: AFuF++ks3DWEgBHyZ9getwbTfwM72+6aorSU+toVNOUk7QPSy0WnvUt6
	JmYvaNKDnu+uZ1Mw43KAoxCxoPh8+3RcXe9VzTDM9bJI8P3973WilGw1
X-Gm-Gg: AYBFou3Axs0LPeOM1lr+SskoVNOHJ+1ZVN8KyBXHZK2YADHXWC7IgpyKUuQ8MgV9dyz
	hPUKPj3oIGpsMT1lqleC/A1ERkewlKHKj3myUvTHoEOyVBIOuJc12cxhoYI+rlsSlXFJ6VAIqKR
	mJqw/CkcSCRMk7ZF+3vTMdxyB97SbtNV8MUeSsXsSMQDNRKSoylmpvTJjHU612vyDLNU5VKX71i
	BUKemhXNagAsSupk1t1oUAVfGNTCBqTOnD6ZgUe5ljI22cUYyiyeEcICQBwi78QQBgZDxMYK6pc
	fTPhidgV0cSS6uMam9FfI3KAxoeEpczz74fGaEvX37o5TtUaeqioCIez8izzyUBsEfzVBalmoZK
	sGzKaQ1MT7mEVioU+SG8nKF0yMT97pmNZBzyEZTA6wNznGZuRA0wikg1jO4qkaBeji7xqYyMMvW
	6Ik74YwoBJOIeF0oXL/kFA8ki2WiO/6xx4QM2Klb3HML51j2DeMosgl7tSOhoWPTN5RVpPUgFNm
	3/HW36cY6xTz7guXfs68QE9aHSLsu9wuJbsu+QNdWu5yAh7Z0el22S5Wmwxu4R5ueOEtVuiWKWd
	ZTtTYDXrEYjE4hyiSZ/8LNUeiq7nCTshdy8s7gQnc/oUC7BF3+YgTjo7iH3j8kYCaWY586sLXGE
	e1W/4qrT5mh1N+bdvE9OfvKIKPmp7KJQ94pKjk6oWjsLRJJLTbpWaUlj+tNAsD1D28i9AaPciBG
	MAXi1E
X-Received: by 2002:a05:600c:3589:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49e7a669271mr34433685e9.11.1789390163869;
        Mon, 14 Sep 2026 05:49:23 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm527964885e9.13.2026.09.14.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:49:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:49:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Matti Vaittinen <mazziesaccount@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
Message-ID: <20260914144920.00002f7b@gmail.com>
In-Reply-To: <20260914112053.1686061-1-lgs201920130244@gmail.com>
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:20:53 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

...

> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
>
> This issue was found by manual code inspection.
>

I'm on the fence whether this sentence should go under the ---
 
...

> @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> +	pm_runtime_dont_use_autosuspend(&client->dev);
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  

It would've been better if you sent the 4 patches as a series with a cover
letter as all of them are the same fix.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts

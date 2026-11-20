Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182569;
	b=bsuM2PWB06qMum/WDjuX4uwyzowm/IjGqFzMQi6UPJRGH4ZWJAS8M5dqrg/dwX8kSQKi
	 Ej94rkK4gY9HVmVuxvBepCPsguK7A17gvGmOvWWpDtQC2W2oZwhyLwM4xrbBTtWe1crla
	 eE6F9bgoT8HtHyh5Ys/elaFogFzCxiVLGSnZQxPU1MeQfmmELbAcJ3juW74x/3s9ukyno
	 RzYZtZMJzpBmBjO4k7hvMlhSmc9V+l3zLpJmDqZnMStBIKr5Bij/9ighYx5e2iVkzVytR
	 V15eRyd51pRDa7ezyEYGcjA0BmCSxOjR3tc4P6JXg2xRWIJmFsbDzd3mtg2zHXHF9oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=jRe7KGrlJ8zVa9o/G3HkzBE6A8me3c0geOX4rbgHkF4=;
	b=FkZS1k+q4V//lBvWeYrmgrh4iNzeufnHa0egANfgUz0NJPNOQsTU0FZ9xUl2YEBMtdFd
	 Vxg1MErT8cFB3lwdcpQt+nCzp8Qotq0vkIJJZvf2uH7Q70L2wMUaUdpEeVFiUJKJonrYw
	 JD+VTw1uSH/+nOdnB2z286c+lqhxT57UW2+xSJ6AJW0I5vOd3m5OKPL+eLsdlQ42F/Y/p
	 7BJEnAOH+amUlJYy4W4qQWU76hwdeNB0pPav9NY+5Najs9y7wlyCbQIWz2rXQhJryGC9h
	 Hq4SveB3ukoZHgoEscDH6EqpDJqqptQo31XsrkdSGQKzccS0MVVHV+VMLtngErh+aEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrLNMmM9;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6360A2600
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 13:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C6360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrLNMmM9
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so425108a12.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182568; x=1795787368; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRe7KGrlJ8zVa9o/G3HkzBE6A8me3c0geOX4rbgHkF4=;
        b=jrLNMmM9lHGUqE6QnynJ8O2ATi9YDewwhXcStt776MFumhI4uUiEqMm9VR0Yt1cga1
         rls+rMWKqX8h3UpyJOuvi57ydjE7ehpnRKZpnyAbyIrfEuUgeZDIzr4L0+Xr1UQDkfeR
         Y2QgaaFDCLcpDI9kj43G0huL2Ymccn9znNA+8qlukTWd7CocerqfKJuv39ttE1woWSa9
         LIa8UdZmjQ7ai6YdSege2XTpUmS5IVmVGEbGsYDlGcvT7PpBCHX+M/7DUzXJC8YjgB2J
         7XFeRE+HT4TQ3750cvb5cvKOxUEPBrSEZDKHGNfhlrJ2Wj5aveLxig7w9GG1Ys+ZM17U
         rCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182568; x=1795787368;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jRe7KGrlJ8zVa9o/G3HkzBE6A8me3c0geOX4rbgHkF4=;
        b=nZ9JerMxBm2xQps3iCkLxUJ/ePI7fqKRLPiDKqN0NfDi1atGQ9AYCT1OLQP8UZy2yp
         DiyxqrCb6gkShEnW5T5+WzRG0ymIO8xyZJooekHQrErwwX5+UzwTXERt7ME8UwJ7GP/S
         kRY3+m2d6OJjxDSGQzZ4ciYCCkZji5dP0rXxBOgtiLV7K+fnpz2S9gdXuUOjCcIuZwYF
         4DDtLaIeqEucnlAj9wZLcbkdMc6qEBDyeAGCFYb4Sbs0rA82XFXCAHdPL2WUbYi9hJ3I
         2zBQu6SkkXtBuvj4m7JZ1+bL96zRQbdlZFSZ80WKK61VjikwJ75rRJJ3aUm4Qohp6BUR
         1a6A==
X-Forwarded-Encrypted: i=1; AL+hErF4CgZRa7U8WKo88mm8y6EFaVsQsSAghUnp3qqqV2AsBIjPJhuYp8+htaxjAxNbgJ8SYAscjoKTjbQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1vbUDQzCFaI/71dcjfb+G/BbCMri7whljdMxR9zyYAe8h/CRG
	qBOVvSMpSEJ+A0ZyCGQHkkNqN8BN4MJN6XG3tfuW5T0iSvJTIBNXPl8X
X-Gm-Gg: AZFdTZe8rfUsTdNYHN1Lrd8qP5BnxU/KvmTETqAGJ7Zft8TGuqcdj6LeRQ97D/sQOxJ
	FADW1Eq6HiFipdMQGn08AUCPRPXGE6GoivOm2nJS7GLr4kIcE9H0/FzgxYGei2AeU9dyk1yp8w9
	PunDYIFt8hjne1oLpfOD2abSLCatOUq3zJeU8IlWdZo7pWJAVn0zb/s4uGl5swPs3rtab9lO7rO
	t7gE6v0DZMqe4q/UFVTyi0lzVgwQDJZRSN+QbF4mbhfr8QnArNsZHXUk0eDBogsFEUqTf7zaHwq
	1V0haLo6suI/vhHIrrsMCFakA0XbXejxNFgyPpYzGjY/EZvoK1dlj09vlr8bFRRLm5qgPnqlin3
	3BKxgvM48N386Zy7eTpt8fJNvgzF9CduMlcdq/RFPDrblQcYkT2qrIJyDpAU4CE6ct6rD6Ft6cj
	FaYFWrNVvAGXXYNQ6yjY5odMchy9W60+Y3R0CiAHPAD2///hUHUWEbymj8V5skuqYVyu3Er3cr9
	liXQ++H1sTQjts3WyhZLP3U8fVZDYJi+UOPbcu2o1Pf+CCgznOoDgs29cTqfaJppx7DZnnfaHyb
	j/c+L7HcZ312rB37PqE1+rE2oCALzoJrKyJaoA5FIT5w56ot
X-Received: by 2002:a17:90b:4d0a:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b41c9cd21fmr2674313a91.24.1795182568459;
        Fri, 20 Nov 2026 05:49:28 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm4530596a91.14.2026.11.20.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:49:28 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jiri Kosina <jikos@kernel.org>, Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
In-Reply-To: <04f2db47461eca6911038bbdb3d8e036dd92776f.camel@linux.intel.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
 <04f2db47461eca6911038bbdb3d8e036dd92776f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 20 Nov 2026 21:49:20 +0800
Message-ID: <1795182560.hid-reply@viennaoffh.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

> Ayaan Mirza Baig posted a similar patch yesterday.

Sorry, I missed Ayaan's earlier patch. I've refined the fix to pass the
callback data and skip children without Sensor Hub platform_data, and am
sending v2 separately. The #syz test request was rejected because syzbot's
automated patch testing is temporarily unavailable.

Thanks,
Zheng

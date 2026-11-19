Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055603;
	b=Q+1UGXt6U4qBn2GQJ542HacLUgJUqqCCYCpwby8NjeZRy2oWAIQHhIU9wgR0Ul87fPLL
	 JJIGWcEAiNu1FGINGzqafHxLkYIFlm5zYN/sadMGUSdlo2u77XTrD4yezkRHv1XOOc7EZ
	 kAlY5JAO2fWkLIFIWJfXmmXjktEYc99YOT+hF+Y0Fn3yMptapuFpr1AL8j1VW3fYwJXkx
	 jn4GPs1DjMTgKrcgITgorpMeTu72gvcTmGzYsP05ycLJLsn1pst/nB8MOtkhu/1jX+71Q
	 ZKIYj9QR0Y9qnsIFgKt1e6AgzT10QzLuzhePPPG7cZHinVit4kUXhdUCn/BG8nMnzhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055603;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=I/jfGs/XzNLUiU7wAzM8DFyhVDcqDrY/sEe4nXwm45Y=;
	b=uZUvl36ZXHZY32DA23UMS5nUzgWzDRrq40rjnpNvObLjXkNad6winIJAdUwHlAdKz2+P
	 278vbsxPXh6PReINMcf7Fmj1gUNzK//qYjZADEME87zaluxYYsaNdrg1dUksFF1ffVHAD
	 R40p0DeWi+V9AiTVyH69+RpJhZnFBLE+IF4cewjXA2c9pPmetvtC4mhzkdM7sKMnCSnoF
	 gURf1FW72damjZZj5eObJrrvwUd33OJXmR7t/XHdbTD13gsheZk0dAKmBXsvYBTKNAXX6
	 3iLglU9r65bw3TQI/dSkzjVH8Olj++fwq+dXAqyWgX2iDx/mR6jI6Cv9/Y96nurXaqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yosoro.hk;
	spf=none smtp.mailfrom=yosoro.hk;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jBbCCKWV;
	arc=none smtp.remote-ip=43.163.128.53
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5E60A260B;
	Thu, 19 Nov 2026 02:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B5E60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yosoro.hk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yosoro.hk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jBbCCKWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795055598; bh=I/jfGs/XzNLUiU7wAzM8DFyhVDcqDrY/sEe4nXwm45Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jBbCCKWVg9htwZWHCKxRq2IQ8o/Bijrt4J6ISd2IA8Fkyj7qYHh5s0ZrINonRTBzB
	 H2JX0G1eZW4ttWBi+wqMXUzyQ2XG7oY1KPkPbOJPhJ6o2Ssj3YM45b4Dd9oENphS6d
	 EmK0O4Dj0Ufn1EQ6A6QQ8wQlqn4BfwCcK9xgGAqM=
Received: from [192.168.123.32] ([122.191.232.200])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 850160B1; Thu, 19 Nov 2026 10:33:16 +0800
X-QQ-mid: xmsmtpt1795055596twex1ec57
Message-ID: <tencent_84B150942865006BA546B43E5026951EA005@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcsXl8tDSMkZcGoVK4TevSkLrgj5/JqliePpNj4ihc2AiUd9pbgDP
	 rwHIj5yBAFhBGFl/6Acd0JBlHlGwl0clbS9pkii7BwZgs0C+aG7c0WU9DN6od15xZt0eJJ2+nTtI
	 +pzosWoiRZ5ryLd0AM9Jfj3HP4pkSJSpVZ1XgA+9oBRFf3f1YDNzstgETGlQgXOYaXqiligWWSZz
	 YOdZ6o2ywiy8sTFeGw8VyOof5jVCSMD/8tRV5oTHG30FxpOfEaeaXvsr60g5XE88zcUxNhQXHBTh
	 No54TJSwrYbc05ypZSIzB7C6z7hBLWL0DK0D50Lhb9niihehmZZ7cw3/ZB0F78BoxfngfYWGm1mD
	 PTHEoASITcazUzgDqk5e7ao2ipMilkhqWT7BAMYrIgkJLeKCGcvx0i735zGncuFi8I2//SIHgZGE
	 70J5vrGi3k6HPb8B4SLReIik/6C/CnOTOIWKrcTdk1Fn4GyWWp9vSlOs41nVnU0BSqvhlSdW0s4f
	 ZWqDdKf4IQx7XBppFyprPxyWGIlfU+FZad0b74oqpaDxugH2iuoJgv4uDcUzPHdZUs6L05/q2JUY
	 tinWfUzGaLakYub9a+QrVTEpa+g1uXsXqQ/5iuB7a8BAoqgv4YigHgJfrOVoBAzjL6zcs9hFXB/U
	 N1mDt7W0qa05gdjWSogE+1ff0Kke4K4n01fE4y5vCN3u01qNRoqe44uePfiJXBZKQ4X4U1/mE++/
	 7S9UXdgj9m7F6sTyYIUQ46A5H0orhhXK/ciPSYNuR3oCsWyL9vDcOapqQthAc+x82AXvdJql4qMi
	 T47tAN5Hz8/xVTpZkA+nujrYZV4aerwzMTSoh3slNrZn2TX4z+qLAmQEZUpTCkJ/bw/Qa/29cW5S
	 V/ChnkNCD4CtTMbYzSPqcORFoekbt3jvW5Ydtw1cFU9iZvy5w53VijA1l+tqFscEI/4mOQhDr8aA
	 G3BgR21AdHLMG1Ubm5xP7oBHc+DLW7R0kDvNGmxLvWntFWSCR6qQX/t6gu0y1bS1WHaUHMY4RaYn
	 5K4ZU59kMnjlUnntkIS+ok84dvPFc6rHcQKwz9nFF1yeWXbfXWAjYBcNstEWpujv0g1XodoQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: NanamiKite <nanami@yosoro.hk>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm32181: Add support for CM32183
In-Reply-To: <20261119014405.2eee7298@jic23-hlaptop>
References: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com> <20261119014405.2eee7298@jic23-hlaptop>
Date: Thu, 19 Nov 2026 10:33:00 +0800
X-OQ-MSGID: <179505558099.21292.3487409760800914194@yosoro.hk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 19 Nov 2026 01:44:05 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> Take a look at linux-next or the iio.git tree on kernel.org. Or indeed sanity check the list.
> https://lore.kernel.org/all/tencent_850445458D21608E9C8821E6728457F31C0A@qq.com/
> Pretty unlucky to hit same thing that was added about 2 weeks ago. I guess that device is proving popular!

Thanks for the pointer, and sorry for the noise! I'll make sure to check
iio.git / linux-next first next time.

Haha, it's actually quite a niche device -- I just picked one up
secondhand to replace my old Surface Go 2 for development work, so I
definitely didn't expect someone else to have already sent the exact
same patch two weeks ago!

Best regards,
NanamiKite


Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72949EC43
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306880; cv=none; b=MDRZ89lZJlglPIxvaSLwIDvmPQCKfXm9WmikZ26omPjQK3T4W/QAS2mP9Viw6w21ihRUyDe0JVdlBjjo68YiLxh3rST6+F87p5n0AgaINWZn4qL/iP4MYkkAn4AuBm2dsAQGH5+68Y6+DxRX8ogYJOL+Xgtj2CX6ipOGaeZKG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306880; c=relaxed/simple;
	bh=de0q0u9wOZaDN3BfzaDpLHztm5ogLHhnn6peJDNVgH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gyZfUSM2cjjAyK3YeedS1ZVYMFbTzz51klRh7xBqjkDnZ6Sbpopl4/am8qMJ83BL2urA4Q0MALIZ4V2U3F+47VoWHpyHo3XQfJfdHYYZTFppybjurAs8aNm0ZzneZ4F0aihr7O+zfH/g9Y+c9/TPQ337jhZdUz+H8napHiZpp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+QF0Jf0; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+QF0Jf0"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a01c6c0f64so6596605e9.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791306877; x=1791911677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=de0q0u9wOZaDN3BfzaDpLHztm5ogLHhnn6peJDNVgH4=;
        b=h+QF0Jf0Kj3zLougfbrd+KzperRO6tQxkHJjQJfVNQ0M7lYBrvrCCWknhSWmFdE/vl
         b5LWoM1o26fnByiWCr0uUoBFkzDLIZHD0EQcdQtn4egLyaMrHvwGyGbcUUbHyiaFmoG5
         cGPEcueBNvSTkQSF+xB1xBoSxv+dOHgoshjuG/6BgixQd6Biv9nC7rL9WSvt+GPfzNXp
         dhctWv+ImhhiPDXZtXwwuCmr2QUJCs0IGpPLqxxub8uquCXWm8AJ86KVvlaw9XP2+l1O
         lCgkJDbWzMedUVnXPykMYyeynMUF0dZisLvrpVEeFQyfUCFDgNnaVpJL+q0MzGrE2UHd
         i9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306877; x=1791911677;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=de0q0u9wOZaDN3BfzaDpLHztm5ogLHhnn6peJDNVgH4=;
        b=WdZFuGX/z8yhmVwjvYJ5oMct8JzR9Z9GedJ7Fj2d/3wbStnc2HxHuZFn0KXWlaEmUQ
         VsiDwsPS0yZRzSOwHao+FAJu2dVvjMZxwpzwnR4KzYdpH+jzxhVBEkN7X92U5Gvq6z0T
         2yuIhA3vomHwlkFJloNncdzI9iMhX5w5hWIy0HaYxXZGB1o9eWbH0777wjNBFKXl1bYP
         UPfvL1XgnBGmoamFB7yHD5B2e4vJdz6sI1vvvAVo41/rA8tA5R+Fhv406VVbMD+3MXPp
         sqdiBaFzaw5GbYUvymc7b4dMBkclrzVtz0Wh4wSfYvEGkaLtq4nnknCN0iTnzxsmsBUF
         UN3g==
X-Forwarded-Encrypted: i=1; AKwUvBzYy/wl2rpc62QWi6I6t/bRZH3QMgrIYIv+GqO0UjV/ajAqbXwkfmP/3EltiMU15PXyIe9nAHioqXw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2mim0s09YKmdv2cIGesmsSXpJhWMLiMb66fNMY8xLUq0LigFW
	TJWs+4Nl6Ja2UhFVLiy4RB6uHHGuENR6Jv4Kzw4nwLo+BThJH1nSiy0x
X-Gm-Gg: AYBFou0pB9uJDymHawqJZ2Am4KuBnXhZXFiQHpgdCJkIaJsLy9NXqhB9GNi4Mi5DpPf
	gSJsJHtieu/fb/FBfbK4hrpFMsAb/6wuBXxRInOcBabWai3vtybbDbINvEVm0kTUyYfaXb4awtU
	I8Azd10CXY87e1hUdQ0BylSohd16j+6diguHPt/RTrPFDa6wbHQ+1cTZd4EF24l9mNZhTmO9zE0
	700VBDet15QJIO/P1Q+IGZgDJuCn7IMK7nVgKbfe5VF5fnS03EwfMvxX6WaXfLlbZpvlaJViina
	4vJvO4QBIJEEmqssB3/W3crqJ+YnlWTzyt58wivZpyd/myl4ItWhAb/0Vxf6Gc1kCMM4DLjRaSx
	Snc6DAeNz4biXjoKmtT3Sqp0moskgiYdaNrLLeaC0uEnNcbsD3YKlw/FUC138BzuyGpD+gKhTNO
	wKrjqCriJAORWtTu6BaVtLPNRkfUbMOnOEUd6Jabjews5Nn8iTAX/N5xdwjfG03Y/oM/vIEoRs5
	g+COfO5KUS7dMJY
X-Received: by 2002:a05:600c:45d3:b0:4a0:2835:6fd3 with SMTP id 5b1f17b1804b1-4a17b547ac5mr34074015e9.17.1791306877406;
        Tue, 06 Oct 2026 10:14:37 -0700 (PDT)
Received: from [192.168.1.44] ([182.182.239.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1f3f7sm636697f8f.32.2026.10.06.10.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 10:14:37 -0700 (PDT)
Message-ID: <84e9de99-8997-47f0-986d-910924c61d7f@gmail.com>
Date: Tue, 6 Oct 2026 22:14:32 +0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: Re: [PING][RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO
 core demultiplexing
To: jic23@kernel.org
Cc: Michael.Hennerich@analog.com, andy@kernel.org,
 antoniu.miclaus@analog.com, dlechner@baylibre.com, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, robert.budai@analog.com, shehryar.amd@gmail.com
References: <20260927185929.70635769@jic23-hlaptop>
Content-Language: en-US
In-Reply-To: <20260927185929.70635769@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

A gentle reminder, it's been more than a week since Jonathan's review.
Responses from library maintainers would be appreciated :)

Thanks

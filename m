Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669193;
	b=CFhWoWtnyDhOQRK7UlPky1J5kW1JRcBAbq3t7QIHeRmcFxu0QybZ58ZUKFtFjE4TDBYq
	 ZvfVb56XddWRpuVTZ/EY1ZPVu/fcb/00GDq52EkBs3r/CgpmJFm29MQ2RB3one0DlHCCB
	 BAFSUUKINYUGR1bPBV3r2GVzxOOwQKHcVF99P290WArZHUqax0FK3M/f8Acd18t7wPOZY
	 E/0mXKSp7Tp3gq7hOh54f9tt04nM+uak7BO0pgud9yrpzeHu4NGFTE8+/i5e1RK88JTwg
	 xIfXAxyXYW7PR6d8RG1mb9V0oL8MYzDA1TflcHEBCNc4Zpg9IJ7J6WROrgdq9HZXURA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xeiikBLPBm412p+eEKjwJKkmvAegh7AP9H8VXVhgxBw=;
	b=GOPSAoUjN8hK5jnrTulI95OY2cDuaURyi0JY+ybeBgCIAEDsyjnaGX171+qAZ+RMpdZC
	 F7aYToESsGbNqVu9szhPvhrjFC3I72ZhtMVNsit3N/jU46l5RpDxL8VIs/r3ZDzgZjCpC
	 OmtjP2m5RMuWyzdU/TutRCJCmHvJc/M+NVoo9MDEpfTxkwHYJEG3jOL+fv8bCI6mQpTt9
	 DARpJJ697+hVHIegfvbXC2wmdNnqbibcD4T4G2GIsVaujrsSC8jXzJGd/6fXsVxEtVWiH
	 ckRr82e4PGTVlZ4YTOnE/ImcTz5IMydnFZP+Llu5OSs+TzwShiDzU+xsjXOCHLZ06fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWM0jOiw;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BA606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A03BA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWM0jOiw
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f04ad2c46dso41451725ad.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669192; x=1796273992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xeiikBLPBm412p+eEKjwJKkmvAegh7AP9H8VXVhgxBw=;
        b=FWM0jOiwEBSB+lT/KzPX7bzbz5pRuQ16gBwwSR7uQCd6sJB2/D7BAzE8SvJtOe1FYm
         +AXC1AlMNprtTA4x0Ddk52naLr9G+CAsExW4bBBscLOl91V1zSyf4/BFsQ7X8TQd2AJn
         lj7qKJLFrUOumZE4m+kFWJhTpjEco2/V+PuTywkRg11qWiPL+733MHMun9Hx+hUY36pv
         Ye3iI963P4iZPeeDypm2xBw8wTetSYBiBv4zj3zonn0HxBCWr3iLyiP8ugm9FAofUHFD
         /SzD20pH4xvg+j0i6fhF3xD//+1EKx+TRNdJiCtzlUbhdwHOTuvA9YYwvcR//ViK3Sao
         YvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669192; x=1796273992;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeiikBLPBm412p+eEKjwJKkmvAegh7AP9H8VXVhgxBw=;
        b=qIJZGdBPCeHqoAbhBXPWtQ/SPXVgAw8OaKVG6qOQuR9uwHX8eng7KfoUeGL25gHAXk
         QlphtEzvjpapKlwNu23M0eRAD69C+CxTPkGL30rhykfm0F2kberf1IjROs5jHezvgvOg
         oVlKZ+UXM28Al3UKAxtWVU7ewW37Kvj5oOgrl8f3n7ua7p77Oi7x/Az3NRhUleDP3xSj
         7ed12llFAJw13qAOaODIiGyCspQ1UPAabjRUHf/BP8jiyjroIOvxL9emH7j2ffcqFeuJ
         8E1/SbFzaH7uNKh48kXkENXZ1nCyz+1fJEMCevDHlsbPG3IGpVZ9VJoHOC/wVtV0AIp7
         09SQ==
X-Forwarded-Encrypted: i=1; AL+hErFxAG79ClQBrwCeTO8hxAcnzz1LFnHun4yZS86TinsrHMykEmM0VZUo+ToTUe+wjz/TelxpGZbOmq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CIaa4nrPR9jQpHl1jMuGbv7y1xXwCoCssXQJSowqRjrzZWVTL
	xMa6aUEv9WxutV8W1PyPKoOBhY/0y09hSGyhYiFR+lfNEsZtQI+CSR8s
X-Gm-Gg: AZFdTZfzKEcfe0ABQyz6Hmbfvq6sIljYxE2Ct2XP4n0QgGVveus1hQtK3iDUWVgY+VR
	4vsEbyBg8k4P7N6jirSQmwS8l4AJLLivJLoavrmEYS2iZbPP1/+bAjw/x0oqRr9tJl9fU/o3NxM
	mc0n5wKCygb91ELPM4IjnOPjfaiA6UJOsx1Ilj+6wJIKJ7L0k9wGDqvLZbHnfmu177LlRtqKTOK
	plZHlfWiKgqX9gZ0/PmPG1c8xTXX2N0QBBGNjvmCPZ1PobufBr2eOZK0JfRI7/Nk9g9i24OdDJ2
	s1ugSqH9vmS291zPgNy0KBf7IaLdhWO5gLX2hy+lcj+/GwX93h2mT6B1u08kKTxIxkcefdXQSBW
	A8+YWAIyZEk/6H3ltFMzJIhX5vbq0kkL6h22+rrpq3nww+SYiD15fwgrKitB08amphmGMvA6QYs
	Dyipq8vzBeBHWpX8wZ6G29JcYLeWlU6Ilchw8oDaRiZ11kGABaEUUNjQffgwQGe3yzxC64PwnMG
	xopkb7vl27tqkLqM5hE+W3S+SnlpLbcUOOEl+/HHUQaDweFBOUonMJOVZuQEf/4drOLpBoZ7QUU
	zcx4lCaouHC/iGBkCsOC0kY2zLmJNfplAGfNM+ezsfrOBIH6hS7xL/ErVu+3TOfGy1E6NrejO6E
	RgHkE6v8ZzawHwzPOVjA9mDGngtQl4IX+1Ok4LFcDLeJqu1l2wyKrbQ1phWoiKYI+yeZ8ZyXFQP
	rVFvQJHA3HmZUqCZAem5jdkpDNE2yY/P9JxP83GkWhEN00
X-Received: by 2002:a17:903:b0e:b0:2ef:ced4:35e8 with SMTP id d9443c01a7336-2f03f1e0d60mr192992555ad.52.1795669191962;
        Wed, 25 Nov 2026 20:59:51 -0800 (PST)
Received: from kapoor ([149.40.62.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f07d6d4bddsm68507395ad.62.2026.11.25.20.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:51 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: iasnezhkov@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: guard fwnode_xlate with info_exist_lock
Date: Thu, 26 Nov 2026 10:29:42 +0530
Message-ID: <20261126045942.518691-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125234827.94791-1-iasnezhkov@gmail.com>
References: <20261125234827.94791-1-iasnezhkov@gmail.com>
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

On Wed, Nov 25, 2026 at 11:48:27PM +0000, Ilia Snezhkov wrote:
> +	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
> +		if (!indio_dev->info)
> +			index = -ENODEV;

Taking info_exist_lock here matches the rest of inkern.c, but -ENODEV
already means "no channel on this node, keep looking" in the callers.
Without a name, __fwnode_iio_channel_get_by_name() passes it back up,
fwnode_iio_channel_get_by_name() then walks the parents and
iio_channel_get() falls back to iio_channel_get_sys(), and
iio_channel_get_all() falls back to the map list on -ENODEV from
fwnode_iio_channel_get_all(). So if the race is hit, the lookup carries
on instead of failing. A code that isn't used as that sentinel would
avoid it.

> +		if (index >= indio_dev->num_channels)
> +			index = -EINVAL;

__fwnode_iio_simple_xlate() already checks args[0] against
num_channels, so this only matters for drivers with their own
fwnode_xlate. Could the commit message say that, or could it be a
separate patch? It is unrelated to the locking.

Thanks,
Arnav

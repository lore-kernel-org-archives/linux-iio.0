Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015145;
	b=2/NMoqPkNKnHXe2R9GW1zIMowyycR/g6cUhN6Me3wMgSUvO+PwlbkCMUZ4vRW7nXfPra
	 L4BbWUXCYkxGztoDcMCuVRgGKnZlqfZ5SbXUbl/f4+0Wxt0EAC6RJ828cHQKKllqQiiIe
	 trE+RL5PvM8yzzzNkJP3egeDqj36ff4YvoREhwFPPvqSb6An34PcOrjOeOCEw+zhgfTXA
	 c+Fvj3XrVtEVpVFdXC5w4n70ywFxvh0FBkLh8ha1ZBEOWFtgERb5+HObeP/LNsqPH4+Hg
	 DKWedxJFV3fLA5LIqaUvyZB5NvS97wzb3ziEZTzptcOpAh3wIoaB3dyiu58nYSX6YIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015145;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uVKfUnuxlP0ZUd00bHLHidOFf+FRQ5iH7ou1yFoCBxg=;
	b=ZRM+nvTWarHZN4LjJy+cpyhAJX2qOpbcPO9ASJyJfvhz4DpEME1O8XEAXa1JS3/3rjtQ
	 zA+UtajbkebRnS8ezV6EuK/gUboEs/dH6sff8ccReFKtYda7ik5BP2JdkcebvnQjyXmcS
	 7j3q1WUESqlXWO4EWZf8Wru/Rh3tSV2K1J3EpucmaEdEtSmTj0BoLA1tFwFca5AaIpPFN
	 JZ0hFIM7YPH2Zr8yYoDNvQ7hSrTowyqiLWGQ8ZjUpMFRPjgpn9JNqZUxsru5Nxf5NWAX8
	 q0RnpzdDIps5WlKTAMpkrZpvy1hVHP2F4//JEarUSm8SsGJydCFf33zJfEx1WXi40xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFcbTFFd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B6606A330;
	Wed, 18 Nov 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFcbTFFd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795015145;
	b=lfLIQ5Sxlv/AfE9wfKP/HSPuleJUdJ8lrE0GQz0x0VcR6xebMgPNhHicKxcKF7inVgOb
	 /gLlUoL47cFFYiA40BRTmtyE/2mcBxyjA3G3EmzoCkTyJf8UK4JNcDu84c13r9RbSPenx
	 ENZbDZMYRvwDPl5GGRQOt++ZaTe4RK4R6bIcH+U0wzeqMECVMjnr1z790R/hWoHrtuWbt
	 DegzfvpM9JCccYsuJHxGkGyEcluDHIukdNKrnWsQtwHzyus8hRhpiRgfKAusolZ6c/Nxg
	 O0CD5gpojCWEj73njPl9PXjq7efEalR8BvpaUL4sUQlbWMH5JQMGGBzC4aKhUMJI5pw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795015145;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uVKfUnuxlP0ZUd00bHLHidOFf+FRQ5iH7ou1yFoCBxg=;
	b=YFSIkqVvcEFsK6YGfOMv7HsgYQFa3WZFVn7xyEYocqqMMfBC8nYmd5OAs20HzEpC2bHT
	 gO0Jf2J8/rwNYy56IzU0XCJwYL6AM1QO+2rpacQylJS3zssFzpjwMTKfEVacClS5f17Cw
	 c1E1pHkKXWqNl9BuC7nPV7ihBunF8zoiw2N4jB6+KpBO6Il4MqIOTLXLAE63KKjwDIRHw
	 jUSF6r54qM8vugxuv+iV2yb3/P7i8PzKwJCcZUzGdZ7hQSij0pbY+rtvXujBtAD9EWPXF
	 TqTxzLJyrlThBzbNUk6LvreyeN1TzamQIwJe45Gc0z85h+6zyPjJfYyKoeSPKUa8iEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id ED65B1F000C4;
	Wed, 18 Nov 2026 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015145;
	bh=uVKfUnuxlP0ZUd00bHLHidOFf+FRQ5iH7ou1yFoCBxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eFcbTFFdZ0rZNACWRmHD9B2iyOp+yeY4kCSWPcLfbY2ngiblEW+tgkOsnqdcre7sI
	 6M1Z6yPngB8k7KMShH/A1nBiLFmkMmu6vJB5GaCYitFjxZPFQ/h0qTZwZt6owEoVBl
	 alnXBp1RVmbwmsEoxM/K9PHGCZ1VcMttxNJmcCESTYW/J/E9BynYu4b99tUWUPubKx
	 /KDNeC0NhTwFGFAV8b19bgn4YfaggznLywGvYYSZ2TpQepoCOJHaWSTi/NlwUdrbEt
	 1bSQQK1B4+sGJyn3qjQhDxEWfRx7s/Gzjyr/6i7Dqf1M4J/HdlnSx1RtoiOWlWYo+X
	 JwEej7SMSm0lg==
Date: Wed, 18 Nov 2026 16:18:55 +0100
From: Joshua Crofts <crofts@kernel.org>
To: NanamiKite <nanami@yosoro.hk>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm32181: Add support for CM32183
Message-ID: <20261118161855.000017dd@kernel.org>
In-Reply-To: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
References: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 23:11:00 +0800
NanamiKite <nanami@yosoro.hk> wrote:

> On the H3C MegaBook 14, the ACPI CPLM3218:00 node declares a Capella
> CM32183 ambient light sensor (CPM0 device ID 0x7db7 / 32183) at I2C
> address 0x29. Reading CM32181_REG_ADDR_ID (0x07) returns 0xc383, with
> chip ID 0x83 in the lower byte, causing cm32181_reg_init() to fail with
> -ENODEV.
> 
> The CM32183 uses the same register layout and ACPI CPM0/CPM1 tables as
> the CM32181 and CM32182. Add chip ID 0x83 to cm32181_reg_init().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: NanamiKite <nanami@yosoro.hk>
> ---

LGTM.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

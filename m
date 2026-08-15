Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E111B87C0;
	Sat, 15 Aug 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786758740; cv=none; b=CGPQ+a5c0uV+ShkCIgegl74Wwovg9/j+Dx0CAUFt1dUA2HslMqZhJNVWqbbEPXdaj3Zp+5OJY3Ts6igF7ygECy6LyLvN4zgdqgsWlufeFvYnKU0ddQOhaQWlLT/ZwnYq5GTP5eIg/KsaaXGQ5OQPznWkGH/C3iqlxgrFNi9C128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786758740; c=relaxed/simple;
	bh=UodzaCqNmgQAz/1FuQH5+/uhhi6N+TbK+KWDow7E9UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohrQUhP92vxux+ABRE/Xq5zsxMCi9vTRolyYQnKPyk79YjKcoKykaK9qXpr96sKRgACW28Wdye428ZEcVKLcxa0GXyepZW664+m84Gd7ar51WJjo4ldgH6H63q1WTWeZBp6lo8vGhkZ3g73wEcWFKs/bkN50smNCNMDtoV35jFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3viutBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3viutBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB381F000E9;
	Sat, 15 Aug 2026 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786758739;
	bh=3O3WrexwJC1IwCK2ZQDYE1WLv4B9LI47oY9B0YdvWyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l3viutBTGOxBM9hejZ+sNjtf+k6yxO8Rgs62sbYI9MiafqaaJi4UngmHLUwnBvLeQ
	 mm/s39JBkjFwpDpXd/GSvSmH1ioyJYqHUMWy1AFlC4Gzo2lupvCGEZR84M/us8RZV6
	 Pf5n0SQrIh94ga8Pf6pg4To/dh31u51GVTS09AfBW+J831NjjTBCWqFITw5tsHmzsD
	 MjO0Zvmb2T8qJOnHUSAEyFyWRHXYZhCGGeNLntKYrl/E+EGZcBawsVjFa6H3QezZUe
	 Oy8CdZRrXiRZXe+P/ndfqXf2y2YmIxZP3eN+V7WWDxtEWrEKvxf0Eb9NbTOQp4TTeX
	 nEsXrtmZY/nBg==
Date: Sat, 15 Aug 2026 02:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <20260815025203.2618cf8f@jic23-huawei>
In-Reply-To: <20260731113632.158440-5-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
	<20260731113632.158440-5-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 14:36:22 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Instead of passing the entire lm3533 core data structure, only pass the
> regmap and the light sensor presence flag to child devices.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio
(I didn't read the rest on this one)

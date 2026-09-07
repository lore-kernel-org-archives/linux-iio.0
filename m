Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97E30B51F;
	Mon,  7 Sep 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746102; cv=none; b=qFpSQFOxSRlz2amkq35n3mCegnf4k3yASClbgawGWjNxbH0PY68M7/yjdNo2fOlnCe5GWqs2XMr+DV3UazO/76QTK3R7f5RY4QkH/UaThZF/OE7gGtJKTlK3Q67FCJX57xPLgsGX/rYZP76J1mHarAu/32q/0x7hXCAwWuKzc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746102; c=relaxed/simple;
	bh=nLbdWf9zqa4bef8ZgcrkMLYPppY4EPXwKv6FQzSqK8w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=shCfTHrdA86tRieDHpZ3MnKrjvb/TiDSg1v/eMEaWKAQg+r0w9PSlQ0man8Sb7f7ZUDi+Aig7576wRmz+NYdo7RWxHjGB/F9w3g6SXtsYDZ6wQjpBH9Jnkgh3Ck5CalYm7aBYoS60pAS+Oyix6VG87x01ugZCF0Bi9y6VH4KwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZLO6k1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZLO6k1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721F1F00A3A;
	Mon,  7 Sep 2026 01:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746100;
	bh=Bwlapbk3PEkkL4sfFGALRteIzYD8cRZpb8vIaDMmlmQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GZLO6k1q3xT1iifxIjq5Wf/Fpm5lS4UZQY6ZjoV93BO2JP6f5/s3YQT0Zju1iVphq
	 R7XbHKEwZ47jX1JAEQ4TYBf5QpSOctRyaMsqOYZ8+Ut0qreyLLgJXhibrCqBC9jWPt
	 N0S9DNL1Gg7Dueb5J/UNm7+fI0fmqWzCJXnIhwdkf7jwSlve8XqXNzls8G1hocUsIY
	 0AKomPBm6R7mFlJheu/0oAQfuiydl7ZUihesyJgePuJrRbqXZTS32X/9B+W/3gSzz+
	 WmkCyN2Is0jx12ohvOEU5ipeOZduF3Ry/NA1Y9bhy7QQdT4hXgM8//TdhCNeq1uWWq
	 rRkntc6sPjrEg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/8] iio: imu: inv_icm42607: Switch to little endian
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-4-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-4-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609181.3402141.4159201185317451449.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=660;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=nLbdWf9zqa4bef8ZgcrkMLYPppY4EPXwKv6FQzSqK8w=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhluXVfqvJCDcOZnBmpK9BGIcXf3ErKTJ75T2
 OiX7u2+YfmJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiNPiEACJPLXCdMK4GP/JWOPT3/TN5AINZAqhXxgaoimiE/rUPMS
 Jf8LAyMC/PFXYc0BaJdgh0EW9sAetfFGrMSa5gWA4EngWw5rOeifrzm5SUVfEub+LHgy6RuoUaJ
 xFxJfVuWfXCc9ZyPBh8NHDLjabBbGNSETw+uMCMEgPMZgK+rhoICqmDBnkoPHIrjherUM586Pbi
 WQ80mi7Ydrhw/hRKUmvbacnTpXsgkB715MnMJsKSFMxPssmKwvjOR1HxZ9ICBuHDHI7rdvHHkF1
 UKmbd18On+97k04a6XlhJxTZ8JbirMGqYWOgGnhGhm5wStPqJHdFdsy9AxYWTZIjz9+wz65RqNi
 7aLgX2IpSpNYIj04IJRDDZfObXwCDuxa7UEaELzj9+p+SQeHwmiMEDEqKz3axTnivjEBkVO2CUa
 z2N0fQ3GDEcrg/Rt0k8WxUH6WuDF4oqcKcvLjCQV7OQ7jHwdjEgIGWKpGiH5vUnjrcJM9+BxiMR
 yU9BzreTU1x22SY4r8m/ybrUjZ+cIXR/SIClmTocqOKZ/+VnfsGeGW//mc8OxneOuQqohZcuJwa
 BINve6TIMQz8YabSVg4OTSm1/lBdZhKQG0sOE4v0c4o7zEicPIZ661u3oJIOZ6y5Hl1cW1Zg+gF
 XPcn71G/fUeZy2PmBh1vR040M7QawDuDhpO3r2w==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The device supports both big and little endian formats for sensor data,
> this is handled via the SENSOR_DATA_BIT in INTF_CONFIG0 register. The
> default value is big-endian format.
> 
> Switch to little-endian as it matches the native byte order on vast
> majority of systems and avoids unnecessary byte-swapping.

This is an ABI change.  Whilst in theory they are self describing and
no one should be assuming they are stable, in practice people do.

So we need a stronger reason than it saves a few byte swaps.
If there is nothing else leave the ABI alone.


Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

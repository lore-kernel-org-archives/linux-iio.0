Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5AB2D0C7E;
	Mon, 29 Jun 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757598; cv=none; b=lb+FtrQ+dc22XU3bi7gM/W1eSUGDZ1tyQf+D2K92G19eZKDCXF9VXxu6uF9A5OifiH45Rgnd9sAotQRA5YG485w4X5JDB1hWZ+B1E2Ovorb6/wxRy1/BOiQSIr2+BUxcyl1sChGVMqMX7FEq/qu/6Z37bYNTdJFYwbZ2FM0yEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757598; c=relaxed/simple;
	bh=7kWvP29BCrpr9mVTmNwk7CuOjuoKbgEfh7sEUZRlSmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qreI2cGITaTBCpFCfvr9kzJ1ftTzkMFRzzyYTrMoBHHfvH3WiAhGP5su2ppzoV2av+4ypNwON6/T3/kVXwRf0HszasvvIV+fLZ8me0jhP2HivU/OuurZgP/0VLUu02tC4sAndbu3ZrzRtOwupULNVZt8kHp0nx3fj5jRsQXhZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEc+Wk7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEc+Wk7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344A21F000E9;
	Mon, 29 Jun 2026 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782757597;
	bh=uEi8AJcYIpDVSytigTu4j+k6O9pdV6mtz9pqsyI+NtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bEc+Wk7yr/VvyOJKXmvAz3XnVrfI73ZxBWW7PIBVlh1ElQTk1TbTvp9DBVt/fHRag
	 gurZD67NFJsy1LsqzztU25941APSu/62y1tmxQqn8HrEOzDGB1rBk7i/LmbQo72J51
	 oWAWgqsd6P3IRsUp8eipikvt29Y7cL7UBHGO8KdxQ7CffMup5sLxXOAvZCH+eB9JMy
	 AqcUh4q0bsTjRRkDRlPIYV0YU19CiOGCKvu+3Ri97XaDVShFI08fqG7XX4PH0lMXMU
	 aPEV4EQn8khUyGqsE6LrL/6NsyWRbuf1rhsX+ymrui/F8HJSu56RUMxcZ4YqIvr2HL
	 94O5EuutOjSTA==
Date: Mon, 29 Jun 2026 19:26:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio: dac: ad3530r: Add support for
 AD3532R/AD3532
Message-ID: <20260629192630.21ae81c4@jic23-huawei>
In-Reply-To: <20260629-iio-ad3532r-support-v3-4-f6e4f4abebbe@analog.com>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
	<20260629-iio-ad3532r-support-v3-4-f6e4f4abebbe@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 16:31:07 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
> dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
> bank 1 at 0x3000 for channels 8-15). It shares similar functionality
> with AD3530R (channel configuration, LDAC triggering, powerdown control),
> the main difference being the register address map due to the dual-bank
> architecture, handled by table-driven helpers.
> 
> Add AD3532R-specific register definitions, channel specs, per-bank
> register arrays, a dedicated ad3532r_set_dac_powerdown(), and per-chip
> regmap_config to limit debugfs-exposed register space to each variant's
> actual address range.
The change to add the ability to provide different regmap configs
would ideally have been a precursor patch (a noop easy to review one).

Then this patch would have been just adding the new device support,
not a small refactor as well.

Otherwise, I didn't see anything to add to what Andy has called out

Thanks

Jonathan


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B73B4EAD;
	Fri, 15 May 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828541; cv=none; b=Ga+daFmPjF6eopzlpId/giROXJwaIODlshoSB+ZZqIzYpkwNz2rm9SQIV7J2N8SRQXzbL+PrQhzGK4YytCOZvKJTYxptbb6uc8e46IdufvNmOhYXY4CWOVHKvmruFScBeh5jv15Si/WdpzIlF+GpOw9cE7ogmBs7E4kouhIlcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828541; c=relaxed/simple;
	bh=infEMyyhtrxQ0M41dfyoFzrIqVn+pnVRQGwfYULyYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNsqQpXksSzMV5maI0pgbEvU8UgK7FHW5pIJbeDpO4xjF9Q5rXl65W9BbBnSWbb0LSBasDbkuD6EoWzxigU2RhKnhMxx3scI5Ac239cgK6rjCcvus4FR8FKYzqXprVSm+ltp5j7fz0wqNbqLF4zfc6H41hw01F1HujWCXbadWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGu7b8cX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGu7b8cX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17E7C2BCB0;
	Fri, 15 May 2026 07:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778828540;
	bh=infEMyyhtrxQ0M41dfyoFzrIqVn+pnVRQGwfYULyYWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGu7b8cX8mwhuFU9yqP4IFYAauHjXCL/XmY66t4lEs6WSIQazGZ8HwnaraftI+2HU
	 gJLyH2FTHPDWvLwL8qbWqHPGs8NlcWlCO7FcCIPy44t3q0JJBlUYN87DOhKBj8Rzvr
	 1V/53GjtavwVohbI7Txz7GI26BJe9QD7P7LXmiZ1PB/Rao/f2NufkdpDOv0SNzdSni
	 Gl2EkvV5QxqU6896zJkmQW4ci9myVxZnG6VP4VEwh1rjS8DwcprhTxLKkAPrJfsBJu
	 D+5RhL73tkaOklB9hGl7wWFa51LonkrtGqA+XXpGuNvgpA7SaDaSQbnNZcAR50NP43
	 0ZPe7f2V6PKwQ==
Date: Fri, 15 May 2026 09:02:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: chemical: sensirion,scd30: Update
 maintainers field
Message-ID: <20260515-peculiar-purple-bug-c96bea@quoll>
References: <20260515011639.28570-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515011639.28570-1-m32285159@gmail.com>

On Thu, May 14, 2026 at 08:16:39PM -0500, Maxwell Doose wrote:
> Tomasz Duszynski is no longer the maintainer of the SCD30 driver.
> Replace his entry with mine.
> 
> Link: https://lore.kernel.org/linux-iio/20260507172404.80435-1-m32285159@gmail.com/
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

This was supposed to be part of that patch.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


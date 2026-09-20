Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FA2C21DF;
	Sun, 20 Sep 2026 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866869; cv=none; b=fVBIwd68C66bt4Ox/82is6LscJ/JIfdhu7w5P1zbuW4QdO81qpuTf93WK9xUYh046F9RpopOL6XadXUYJ+OoPV4V7742yuqavXbwqgsOkOiXmF9MZMS76xfwOatyRm/s5S4/5VBZW9qEWpXPjOgkUiJuU4gyRES2m9ZbK7NBduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866869; c=relaxed/simple;
	bh=JjP1DnidvpScnAcxKX2haood5NSHHVloUggOgS7Gpks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maq5idv/1bdY/O1sRCmmKj93TdR/myLP5j19x+6KExuLJXcqvIvsB/BHN4YBGK2WB40ZKcgr5NQHxC9on+BBfXkb+5etO24E45U5Qj6tIsRiaJSb4LZFUdrn+onrntwmtXv/oI6DeQfuK1C9YOpQJNBhvIkeZWKzt5tFwBoc6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enF0ISP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enF0ISP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0B01F000FF;
	Sun, 20 Sep 2026 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866868;
	bh=GJcRKwtjuE4ZtgyLwbUJ3vtkOSGAuJloihPgH2Jyn20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=enF0ISP9TMMsX8gsOWEo6XiAmv0JWbZfqJarOQ9zX2Z370N0qzLv+gXYbF/ESkL8z
	 fU2Ka5Y0HDHq48Bm6+KVAQqo4uqlO7sT+NiO3AehLCca/7ZeDp+4J5AIokbF45jByv
	 4bN6/aYOLe/1zDYVqtMPPTgblYgBL8M4d7f98B6LpUEvhiRxQi4inlvRzw2AkhINw2
	 cLgS+JhkTBH435tjEJVUBuoSsp1CD88QrEybczelKTlVYbKtHr+onLXCvqEXZPiFeV
	 s5OqNi8GYBMY/7T4dPia5SeLYKdzwzu9lZXpD3K/0BKMohMQ0st849sNxE+WlTtX7/
	 wu+/Jx7dj/vlQ==
Date: Sun, 20 Sep 2026 02:14:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 1/8] dt-bindings: iio: add Open Sensor Fusion device
Message-ID: <20260920021420.5a13622f@jic23-hlaptop>
In-Reply-To: <499ecb38dc0b58b979ca1f38d2d30b4ef56cf825.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<499ecb38dc0b58b979ca1f38d2d30b4ef56cf825.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:39 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add a binding for the generic Open Sensor Fusion host interface.
> 
> Open Sensor Fusion devices report capabilities and samples over an OSF
> protocol stream. Sensor channels are discovered at runtime from
> capability reports instead of being described individually in Device
> Tree.
> 
> The protocol version is discovered at runtime from the OSF frame header.
> OSF GREEN is a product identity, and OSF0 is a wire-format magic value,
> so neither is used as the Linux compatible string.
Sashiko raises a reasonable question about what you'd do if it turned
out your current OSF GREEN doesn't quite comply with the specification
or needs some additional quirks.  Does it make sense to have a more
specific compatible with a fallback to the generic one?

Or given this is mostly about device firmware maybe this is fine.

Either way - would be good to add a note on why that doesn't make
sense in this patch description.

Thanks,

Jonathan

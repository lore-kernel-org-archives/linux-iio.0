Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DB488763;
	Sun, 20 Sep 2026 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946231; cv=none; b=Qkveexd84igVHmmDaq4hJUKBnP+sbpduD2Ysy8XUz8OFhSwfGOsmlEPRv+YSupYsd4dyzQ6m5if9+klmgspisrFl85M4iMQmNt0vaOPDk1sTZD6D5VBUWwfuvZip/6qDsiijIDNq8go12b8CFRubCBJvKEwlb5XN7oRyuG15GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946231; c=relaxed/simple;
	bh=uwQv+gsZQprnLWxIK7LbEhpURpn71iFDNKNtfyWgzUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFDXkOivZtS/LT5PbxBxGN9kAHqTsl4nwfvbbmCxeT0Ud28/qyDDfo2z3mRHj876TVuaqIsxShhiAcazXLYYKYqRHXml9YTnJX4mLfmhm71H7bYqL6J3GST88YPp4qZPUclqC+tdS/dod8gA1+fj6+UQrsTtJh6J03OqwATJX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXchSqOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXchSqOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A394B1F000FF;
	Sun, 20 Sep 2026 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789946229;
	bh=iNmqXhGZZ3SwaOV8bqOvV8+pT+SPZVFh4wF6oc2IRlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KXchSqOMRu6y0GF6EJYza2QP88aCzZmwup1XUPGrasdEXOhI6G7OJ14iaK1CWpkJs
	 yqDplcxA/MrOg7wIZwopBhu4eSf0x2hW43ePFgdnb1T8ZMGX4KBu4ZJhbq905a+M2B
	 /QZq8nTfycPwGGIPWRLsEmzwrLZwV0Mx2erm3tVKNSXQuHaPkO0J4Bk/KhqqPUr36b
	 LQQTXQ+wRVrHLNYaYL5uxJlfha8588V9Hp1xwdIzVyqQGtskhuqi/Fwt0mI8+W6MiC
	 nyvSs8D9Mn/PNqMjBa9q4p3DN9FDOlq1/cC3K9rnEI+ARfCKV/s3bGi8ip+Wjn8cPq
	 k9TKIz31I3z4A==
Date: Mon, 21 Sep 2026 00:17:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee
 Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 mfd@lists.linux.dev, Roman Vivchar <rva333@protonmail.com>, Luca Leonardo
 Scorcia <l.scorcia@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 0/3] iio: adc: add mt6397 PMIC AUXADC support
Message-ID: <20260921001702.3a208780@jic23-hlaptop>
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 00:31:50 -0500
Ryan Brue <ryanbrue.dev@gmail.com> wrote:

> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
> reach. On boards built around it that ADC is the only path to the battery:
> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
> boards use have no ADC at all, so without it there is no pack voltage and
> no state of charge.

Hi Ryan,

Please slow down between new versions.  Unless a maintainer is specifically
asking for a quick turn around (sometimes happen very late in a series) at
least a week is typical time to allow multiple reviews to come in
and hence save on effort all round.

Jonathan


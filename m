Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88D3B5F63;
	Thu, 24 Sep 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260813; cv=none; b=UxgKM29lUXNCTGcpGE9+8nrMjr9CnUTvQeOq5zUTamoGAyp6RPe6R/Nl+mwen0ZWeJY97BH1o0NDOrlD6IZKAosyn+a/FcuXnV0HqqulQkZN+3VU8tsYeLL++YQnG8HV8q2OyyVkIgXqlftEhryGC/rgA+zk/3IUVzdVGMV09Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260813; c=relaxed/simple;
	bh=7FibWX/faPv45zX4OxvywYpnCNXLXQQk/dMKdoa/iD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njp9XUEJOC1PheUCsaeWiYHiv5Gn0Fj7fXBURqpopPl2KL73/YMK9PzHv+2imkQQuhrxkUcQqYJmLO2NI1cxDnmHqUuCcCjQvkMxqEhTNY0tN5iU4KlFeH/Sn5efekMDEZNGvAKfI3mO3oaaFdt6xKp/IE/nSyyr0sOIh2kJxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZMU2c2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZMU2c2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A1C1F000FF;
	Thu, 24 Sep 2026 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260811;
	bh=vb7dXJ12T11BKP48fJBn1yk3HKmhSHRr4ctLGx7xpD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZMU2c2RocbLav0HDQGUZwvS/2wO08FZQD9JBGrUuO4ENM0MPqEesqmpye6Sf2QiQ
	 LllIryGk7ED5JOq+joXC1FRyUj8+UhvC1Pxlsoj+7OfTCe8erW8oSu8b7m8fZNYsn+
	 /VT4l8oGX0B1+aGKxzcsxMt9m/dyMO4Q1mJQpeUVQxBPAKMP4aO6Px4ULiAHyhkebS
	 Sozes0OR72EyojpYJsIBMSc6FOS6m1zg6ic2b8ORxfKi9jUrF1QqLkEhCImll67NcW
	 5e4rnHRL3ESLxsUfMPu4AL8DKfk4nO1NseQrH84c9uV6GTWFfvymHc2q0UCSA6fLRI
	 yCSetLHpWsIsA==
Date: Thu, 24 Sep 2026 09:40:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-renesas-soc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Biju Das <biju.das@bp.renesas.com>, linux-iio@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Message-ID: <179026080913.4146821.390521831954658305.robh@kernel.org>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
 <20260911133653.115553-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911133653.115553-3-biju.das.jz@bp.renesas.com>


On Fri, 11 Sep 2026 14:36:45 +0100, Biju Das wrote:
> Add the renesas,r9a08g046-adc1 compatible string for the ADC1
> instance on RZ/G3L, which is dedicated to the on-chip TSU (thermal
> sensor unit). Unlike the other ADC instances, this one only exposes
> a single channel (channel@8), so restrict the allowed channel nodes
> accordingly.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


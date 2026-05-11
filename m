Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEE423A8E;
	Mon, 11 May 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516165; cv=none; b=MsB1MQC5slt84ggYz0OhP2mSOf92WpwUdJQnHASBHX2ueVwvZrI53qVE0zHigjnuOuXBNFxTnpPgMWgY24rnwq/Mzmzo5uqQEE7mXq6C/TtkKPTMwE7qdzGcwYrp6hV/LDQ5aIKayEPMDgGdtCfK4vMv7NmSkKV5eoGZC9bDdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516165; c=relaxed/simple;
	bh=Tkh+jKJ/HyweWFm1kgLTPcevVPY1FTld3W69DkR2W2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU4IhsEIJ73sP/J9q37/10sBuhH1zGSW7za2hoCMlxWHdAtMZtZF/NV/+wPTeqbqmVDV5d+bjXlO+cAuAWl4ZRphOqhDfvPOPhn2On+ciS6Gd/CoNNOhrp9KtlQnCejeGFV7yFcDpLjyDOu8amF/JyhUI9WXQ2eAXN3rChQ0h10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjopzip2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjopzip2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BBDC2BCB0;
	Mon, 11 May 2026 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516164;
	bh=Tkh+jKJ/HyweWFm1kgLTPcevVPY1FTld3W69DkR2W2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tjopzip28MhLehp4hRjx8JUwAh0/SjqSTki7LJO54v/RDR/zr+Eaoc4MfPhed7fTb
	 toGS4r/1B6F8q6TYuVhUX8O00py1jeUNL4P5J1SnoU9qM6R6JaNnaqnz915YRs0L2V
	 2PsKi0vPkWB6R8XL22wod7E3nZG/Z+/YFpJy+ZnIVBKlu5edcYe6KRz10GUUw/62sO
	 qnp3qpaw9jIULRLilyB8Y3S1aVvy6Hic+gv+nOfyHC6Eq1POmaJO21R+SobBtUB3tz
	 W20wx10pOfViwgw538xxLRGWPAJ/+ScZwOFxTIySBipX6R6eo43xqE6zKdKHF3ooUJ
	 euUacNRwuQ6tQ==
Date: Mon, 11 May 2026 17:15:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pramod Maurya <pramod.nexgen@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings
 to YAML schema
Message-ID: <20260511171554.6541042b@jic23-huawei>
In-Reply-To: <20260510120141.118057-1-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
	<20260510120141.118057-1-pramod.nexgen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 08:01:36 -0400
Pramod Maurya <pramod.nexgen@gmail.com> wrote:

> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
> from the legacy plain-text format to a YAML schema, enabling automated
> validation with dt-schema.
> 
> The new binding covers the same hardware and compatible strings:
>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
> 
> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
Hi Pramod,

Something went wrong with your sending of v3. I have two versions sent
half a day apart and no idea how they are related.

Anyhow one of them got feedback from Rob's bot so I'll assume we are
getting a v4 and wait for that.

Jonathan

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142B42316C;
	Mon, 11 May 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516290; cv=none; b=XGMlLgQ+IHH+wJ43o25nq1ebSeAZVXw4HOjuXK1Wj4eyiXUPAz40uu0XaDh4ejb8/+V+UNuEqBRj8btV/en92c/s04Ob3rUQrIe8/l3roh7nrsA/HNdWA7yqRAtLyqslaJ74vWriA2ixXdgz5LAZQlJ+WpwOm6YCyq6rEj4pkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516290; c=relaxed/simple;
	bh=YxvORiIZBfulrMnrmjoNFiu0qMUXNTX2BFKfPnRUsNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS0NRjeqC7S1zzbOoYl1Tf1hFSl6v6qOaXI740rbl4z47N3bxQGAqfnPEBYKqcwPzlJQ2id7TKkl/JxEMt4ZCVfQbt7kRe1RryDr2hEiqkr49dhvjdc2VqctgfJhdbChYlJv+dUP1R9d6FQ0p9rs33Zu2FFKz2jGv+cU8awPs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJR4Hyjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJR4Hyjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D5CC2BCB0;
	Mon, 11 May 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516290;
	bh=YxvORiIZBfulrMnrmjoNFiu0qMUXNTX2BFKfPnRUsNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJR4Hyjsk4FhXdj2HAqhzZ+l93E+n6xFXon4ZLKmdNtt+WHm72+lo2v7QAb83evev
	 4RJLqH2QIofV0dZ9x/zFWr0iEDCB3IiFXX+zJJU4o+6B0uKziqmnqAXyvkXGIfsuvf
	 YTgA9wjg4hVFnSDZ7tO/pTxWIUQVv8tFAF2tkF5ekXyz8/S+LWJyPLpceFy6jYJ5ru
	 UJMBFl44AEM9RF96zUf5qjCQSd82zBi2KbOo5wrspD5vukEwpJRHgqJ7GnSDyPjjAk
	 OX7Fs1HsIhBAy735SxPKnV+suhmGaml/Q8kL1jlg/SIepZ/ZwikGFq2Ccp//4+uvTj
	 0Fcg7cB5f2A3g==
Date: Mon, 11 May 2026 17:17:59 +0100
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
Message-ID: <20260511171759.46a95f8d@jic23-huawei>
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
On another note - please slow down.  I now see that v1-3 all came in less
than 2 days.   Typically wait around a week for a significant patch like
this - that gives time for multiple reviewers to take a look.

Maybe we can relax that given the v3 many versions confusion - but I would
still wait a day or so before sending a v4

Thanks,

Jonathan

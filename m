Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A49288D6;
	Sat, 14 Mar 2026 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773488471; cv=none; b=slbB+gV04gqXhK0gAYKai66O8CSzlsnAP/JpSu2l7Htp4/sqGnS5Ttj5a7GV22Y6INHpWsEnhcyBoXb5IR21fJ9uv97TPQgGW0sOP/0ICmFViLlmzlRbCRwIv947HSNB+m4dojxaHP09GQLyWijFTmaeLA5ZcYYuueOpo93zSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773488471; c=relaxed/simple;
	bh=O3BZe9xCPxTaURzPF82YIJAoWC+15+99COKbB9Vu6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc8nMP1T9ido7TsNuONgE8cK8G/FQEJamjUfYO6w080XD9A71Tx390KfSpK+cXlmqUxbHJojVPhY8vCtIcvRWzFlMYXzuWjxoFVWTeZFcZk7LO6xWow5Asl+PQn4hke+QZHMcQbPDIK06seJPsxy9XxDuDyIhj8rDIYhVYoLk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcsooTBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcsooTBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7D9C116C6;
	Sat, 14 Mar 2026 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773488470;
	bh=O3BZe9xCPxTaURzPF82YIJAoWC+15+99COKbB9Vu6g8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dcsooTBb5HG9+JhLQ2jcND3ngLzibPgroJ6TGyhcBtEKmEK+rMNDA6PuBvUtfHUbJ
	 OIABdQVQsra1BSwPTyinpGKNexOioX/LOGl+w1TwV+8L5kC/KOZWer59mE6a9ELX0u
	 CXs1/wf6uvhKOv7uI5kNWI/oP2MByLXW3KOj34GmgEbTwC/iX7psba1h7Kq/58Jv4k
	 UX6x9t9+94my9d87QqpTkPxLwCzUHbqCCLK2M2J8vIE+6hlPEs6Y/0rZDtlWGWSwfl
	 mUXaI3d13MwOCOwaISTgPH0R8A2/0k682dMKzsGCDbEl1v9WNckQeNZvMRzGiwFtBR
	 MA4zchSyVYDPw==
Date: Sat, 14 Mar 2026 11:40:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260314114058.246bcfc5@jic23-huawei>
In-Reply-To: <20260313115856.87763-1-antoniu.miclaus@analog.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 13:58:49 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
> the same family as AD4080.
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface and LVDS data output. The driver uses
> spi_new_ancillary_device() for the second channel's SPI and requires
> two io-backend instances for the data interfaces.
> 
> This series includes:
>   - Use __free(fwnode_handle) for automatic cleanup in iio backend
>   - Refactored devm_iio_backend_get_by_index() for multi-channel backend lookup
>   - DT bindings update for AD4880
>   - Driver support for AD4880
> 
> This series depends on the SPI ancillary device patches already picked
> up in Mark Brown's SPI tree (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git).
> Added base-commit in the cover letter below.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf
> 
> Changes in v6:
>   - Move fwnode_back declaration back to inline position above
>     IS_ERR() check (patch 2)
>   - Rebase on top of broonie/spi for-next and use --base to declare
>     the SPI dependency (cover letter)

Ok. Given there was nothing in v5 to indicate a need to do a v6
you should have replied to that thread to say you were doing so.
The fwnode thing was something I said I'd fix up whilst applying.
The SPI dependency was a 'do it better next time' comment.

I've dropped the v5 version I applied.  Now you have questions
to answer from Andy on this one.


> 
> Antoniu Miclaus (4):
>   iio: backend: use __free(fwnode_handle) for automatic cleanup
>   iio: backend: add devm_iio_backend_get_by_index()
>   dt-bindings: iio: adc: ad4080: add AD4880 support
>   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
>  drivers/iio/adc/ad4080.c                      | 230 ++++++++++++++----
>  drivers/iio/industrialio-backend.c            |  62 +++--
>  include/linux/iio/backend.h                   |   2 +
>  4 files changed, 278 insertions(+), 69 deletions(-)
> 
> 
> base-commit: 2cd3974b9ae59ac731a4792e1608be32621b6e98
> --
> 2.43.0
> 


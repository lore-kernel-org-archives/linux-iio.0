Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25291E86E;
	Sun, 12 Apr 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018838; cv=none; b=c35/oQIn7tEGGkfI4SBmQyS+VAJ7+rx+s8KZp8RFZWJblE6MAGJ6pOh7uosPjq502Cf5xkaRffbq3b7grwW2QWL3p20VC0OopPGiB3uHWgZoSbxVFTAOdN3JbeMTKjW0VMxNPWTe81caqG4GmUmXhOzg83tU2tRPTBVSs7nIcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018838; c=relaxed/simple;
	bh=z4A0xDuxpo74GD26tSL0zWACGX0HWmpIMjT2c00fu80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHpM3JTxezknZUaeGPHyeb3R9Rh6OsJln2VDP4bEbsOiq+CZq6Iu31McucnA/l/ah5RC+d5kzb61UetL/cj0RdGjGLPzb1TuZLogKR6M1hGzjjNTaZgyPS6Zp18GPZjvmvCdLpg4Xu/I3iNbHBmggODNLvLEQ+2Ld5RdPwak0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv1OCudt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv1OCudt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9CC19424;
	Sun, 12 Apr 2026 18:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018838;
	bh=z4A0xDuxpo74GD26tSL0zWACGX0HWmpIMjT2c00fu80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kv1OCudt4rW4mLgPx0EQq94Wmt884W9r3kX5qxaU1jEHy22u6ujZzmO9FUcp8qqvA
	 SD5ihqH1NnFN9ptaiBRCI3yczQEbpbRSsgRnyyyPdxmQe8DWIEea9xqh39dhn3eBXv
	 +yyLavJyNMxxjH2sWshhxvKTbTgAp8ZlhQeeHZEi96ik1UZRXGOtE25VFmJ3djkyio
	 zPltcHSYFcYW+PRF8zq06U3CaNZApG0dVnJ7drGKiQEOgD/ZEbmWFKoUXyWsrONOrg
	 JZJKbZGNdYAWhUuJ7EgjWk2RgW5HCp+JikizN15lVfz+GaeWmIR4fYtbjzzAb83p4f
	 QRmF/izPGYprw==
Date: Sun, 12 Apr 2026 19:33:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260412193349.6a3fea03@jic23-huawei>
In-Reply-To: <20260328114050.46848-1-antoniu.miclaus@analog.com>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 13:40:47 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> Architecture notes:
> 
> The AD4880 is modeled as a single IIO device rather than two independent
> devices because the channels share power supplies, a voltage reference,
> the CNV conversion clock, and a single interleaved data output stream.
> Splitting them into separate IIO devices would make synchronized
> dual-channel capture impossible from userspace.
> 
> An MFD approach does not apply here either - the channels are not
> functionally distinct sub-devices but identical ADC paths sharing a
> common data interface.
> 
> Each channel has fully independent configuration registers accessible
> through separate SPI chip selects, so per-channel regmaps are used with
> no locking between them. The data path has no software involvement at
> runtime: the CNV clock triggers simultaneous conversions and the device
> outputs an interleaved bitstream captured directly by the IIO backend
> (FPGA). spi_new_ancillary_device() handles the configuration path;
> the IIO backend handles the data path.
> 
> The debugfs_reg_access callback is not exposed for the dual-channel
> variant since the IIO framework provides a single (reg, val) interface
> with no channel parameter, and exposing only one channel would be
> misleading.
> 
> The AD4880 is a fairly unique part - having separate SPI config
> interfaces per channel with a shared interleaved data output is not
> a common pattern.
I tried applying this and it's not going in cleanly (I didn't check
exactly why).  Please could you send a rebased version.  The togreg
branch should be fine I think, but maybe sanity check it against
my current testing branch as well.

Whilst this driver is making a few more assumptions about the backend
than I'd ideally like, I think it is reasonable to postpone any handling
for truely separate backends until (maybe) someone needs it.

Thanks,

Jonathan
 
> 
> Changes in v8:
>   - Drop fwnode_handle cleanup patch (now in jic23/testing)
>   - Clarify backend buffer comment to describe FPGA architecture
>     (two axi_ad408x IP instances with a packer block)
>   - Make filter_type a per-channel array instead of a single variable
>   - Restore debugfs_reg_access for AD4880 (uses channel 0 regmap),
>     based on sashiko's review
> 
> Antoniu Miclaus (3):
>   iio: backend: add devm_iio_backend_get_by_index()
>   dt-bindings: iio: adc: ad4080: add AD4880 support
>   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
>  drivers/iio/adc/ad4080.c                      | 251 ++++++++++++++----
>  drivers/iio/industrialio-backend.c            |  53 ++--
>  include/linux/iio/backend.h                   |   1 +
>  4 files changed, 282 insertions(+), 76 deletions(-)
> 


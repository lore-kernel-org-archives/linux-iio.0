Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539769;
	b=caTGtWSe+3tQCQmumDoYTpZeyLXftsi7ZRRSU1pJrDRiOn3h4sND/spJaCFlQUuCZXa2
	 IaHLNd2m2qGuj+s8P7LIhw4F3CV+L9mx6H7mRjQp3i8cCWkB2r8wwnSAfy4oODGfdQVH+
	 MY4e/soDVZxYVNtzDJL1nBNDsmzNpeHjcackgmcijP68z3YVV30dal3tQlZwLsLa43O+B
	 kBzIg5JB/i5zRD8qnBvcexl9fMeTbQeIooYXyTu11pUx4fxXDnUGXdSh7zJtPEsXEx80g
	 WUENtV7NBRNWeCRppkg1TtBTS67ojhHuS37E98nmZ3MNQQhuaDD8gwMROsSA/tOiWwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539769;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B70zwmDKLeE1Oi2tj/3T4sXH/19QNsW7+URe2IHZSus=;
	b=I73l1GX3DgJEoR9f4r09B0gCDc5CR1kAiv3hZSquapmQQVu8pSpX8lLpfRxlKN19/Cfe
	 5Fl9avSiXnz1AchpMpjjUT5gbC1LO1dYeJtHRjY14TC7ljYxE7ykIDOmXF60iyM+CF5tY
	 NqdRm4eIBEhVMx+07W6e2lQO76sXYIslpmgLKoHj6ZaQg8dSDf6V6F1xw6ASt/s7QLXhh
	 IR9xxT61blm6Ywxs5tkcxViZQ5COFyO+qj3UhO2qccbxG6MuHmcuIIgcg+4nJl68Ta1cz
	 1ZoBBb2fzWeU3Kk5M2GWISfB/8oiWfQeLostuAtN9O+KkKyX7t8c37aWdfXnLnPicBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVbwp4y3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE5606A321;
	Fri, 13 Nov 2026 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVbwp4y3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3132F1F000C4;
	Fri, 13 Nov 2026 03:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539768;
	bh=B70zwmDKLeE1Oi2tj/3T4sXH/19QNsW7+URe2IHZSus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BVbwp4y3F7JHAGwjXLCF86ohG4ulFjLfDO0sKDqRr1jksIcSyTAQ8FIQKEuna/Soh
	 G/PpG8dB4iIBCh6xWosQh+SeXHXThFT3zoXEiQ2s3+9HDuR2NusmgoyIYJdhCPaW/9
	 jx2K15wXp4h5LJnj3+V4c228Cy5QE9UMLlQoYdKqN6evpkt0j3+5wVV2LvI8LuSI/D
	 B0athtkTM1fJFTD8V0fRGW4LscfBG9CVc79Cd9iN+FPnqs5UCfo5ornHLUPO8gNHNu
	 w8zx+3zebZ2b5l5+gb9zFK3x9L77NLH5+hwSlnsSAkjm0w502C5rWsN62bkYfdIhkT
	 +ugTRRM1V/FIg==
Date: Fri, 13 Nov 2026 03:16:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 14/16] iio: adc: xilinx-xadc: Split driver into core
 and platform files
Message-ID: <20261113031600.787000b1@jic23-hlaptop>
In-Reply-To: <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
	<20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 10:31:59 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Split the xilinx-xadc-core.c into separate core and platform specific
> files to prepare for I2C interface support.
> 
> xilinx-xadc-core.c is reorganized as follows:
> xilinx-xadc-core.c:
>   - Platform-independent IIO/ADC operations
>   - Channel definitions and management
>   - Buffer and trigger management
>   - Device tree parsing
> 
> xilinx-xadc-platform.c:
>   - ZYNQ platform (FIFO-based) register access and interrupt handling
>   - AXI platform (memory-mapped) register access and interrupt handling
>   - Platform-specific setup and configuration
>   - Platform device probe function
> 
> Update Kconfig to introduce XILINX_XADC_CORE as a helper module selected
> by XILINX_XADC and update Makefile to build the split modules:
>   - xilinx-xadc-common.o (core + events)
>   - xilinx-xadc-platform.o (platform-specific)
> 
> Reorganize the code with no behavioral changes.

Except for the reorg of delayed work cancelling that sashiko
is unhappy with. If that's intentional it should not be in
a patch that is otherwise shuffling code around.
https://sashiko.dev/#/patchset/20261110050201.1850399-1-dileepkumar.nagavarapu%40amd.com

> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>

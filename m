Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3E30C62D;
	Sat, 16 May 2026 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778929739; cv=none; b=VcDWvM+X+rV2NP7QmyP8dwshACJ2wQHdg6JEBs4pbDYUa9t+D3YeawSO19C9jlzrxGoaAiURRGKjVJd7PJ+nwmxoo2XEAxf6kRtd/EQc4L+tLx3Qr6YyM850umRtFJ1AM7CQUqX6Af7ruc6Une0bnyAvu3PYXVfbF47022OKtHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778929739; c=relaxed/simple;
	bh=zX/VVaabs/4vjcc6ncbX2/r6ndpWLDBC1ITWUcQGRss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tByIyNmEV6HyK1PlvvvOxed5tr6wRP//laqmUohiitRZg66KbRUrW+8/vq/Ws9in38tGXGzS95QvUJPneOfAoMNBdgkv1cacY4HKVYluU2tB4+6Ewd4NdSb+fDFX3DqFPbrcWbQXQQnJOHenL3aClcR5CpivL+PT3ZGWLa93rhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWM+W+zR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWM+W+zR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DEDC2BCB3;
	Sat, 16 May 2026 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778929738;
	bh=zX/VVaabs/4vjcc6ncbX2/r6ndpWLDBC1ITWUcQGRss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uWM+W+zRZ3YKDR2Dv95lKGX93472kU6MlNuP4dEqomxKOFggrH+LTdk1YxelOGfKW
	 c4AdBnj2IK/LxAgp37MVJn8E2623RVP2h3rKjsLvSmOzuyey41/H72yQTL2nMJtv/p
	 8H+AovLG8SBW8N+3LajK5ZHQjwb1svhAKSzHuZe0PUf/A+JFZqWbGwW1RhS3NAuTGI
	 20StbXu+wXfUfsd8KValxzxOl4RbYu7Quvzk9ma2EBHvIFLILOPQLafZvLv4iV7RGH
	 NsF4Olhd1y2DgqDjqeQssRaupLB9J5qglpxmvGhrWtKu+hZTBJnxmrfoM2S8Na/CRQ
	 qa1w018RU0LWA==
Date: Sat, 16 May 2026 12:08:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pramod Maurya <pramod.nexgen@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v4 0/3] Convert Xilinx XADC binding to YAML and related
 cleanups
Message-ID: <20260516120851.00f2b098@jic23-huawei>
In-Reply-To: <20260515075736.172172-1-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
	<20260515075736.172172-1-pramod.nexgen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 03:57:33 -0400
Pramod Maurya <pramod.nexgen@gmail.com> wrote:

> This series converts the Xilinx XADC device tree binding from the legacy
> plain-text format to a validated YAML schema, fixes a checkpatch alignment
> warning in the axis-fifo staging driver, and adds a YAML DT binding for
> the Xilinx AXI-Stream FIFO IP core.
> 
Hi Pramod

Small process thing.  Don't send new versions with the In-reply-to field
set to an earlier version.

1) Ends up with very hard to read threads if the discussion gets complex.
2) Time poor reviewers tend to read latest stuff in their email folders first.
   So by replying to an earlier thread you shunt your stuff way back in their
   pile of unread email - thus reducing the chance anyone reads it ;)

Not that important this time, but please keep in mind for the future.

Thanks,

Jonathan

> Patch 1 is v4 of the XADC binding conversion. Previous versions had the
> following issues that are now addressed:
>   - v3: xlnx,channels was placed in patternProperties to satisfy the
>     vendor-props.yaml meta-schema; dt-schema PR#195 (merged by Rob
>     Herring) now allows commas in nodenames so it correctly lives in
>     properties. A companion dt-schema update is needed to add
>     xlnx,channels to the vendor-props.yaml explicit object exceptions
>     (similar to the existing adi,channels entry).
>   - v3: reg constraints inside channel subnodes used bare minimum/maximum
>     keywords which are silently ignored on array types; the description
>     now documents the valid range and reg uses maxItems: 1 per cell.yaml.
>   - v3: xlnx,bipolar had a redundant type: boolean alongside the $ref
>     to /schemas/types.yaml#/definitions/flag; the $ref already implies
>     the boolean type so type: boolean is removed.
> 
> Patches 2 and 3 are new additions to this series.
> 
> Pramod Maurya (3):
>   dt-bindings: iio: adc: Convert xilinx-xadc bindings to YAML schema
>   staging: axis-fifo: Fix alignment of wait_event_interruptible
>     arguments
>   dt-bindings: misc: Add binding for Xilinx AXI-Stream FIFO
> 
>  .../bindings/iio/adc/xilinx-xadc.txt          | 141 ------------
>  .../bindings/iio/adc/xlnx,xadc.yaml           | 210 ++++++++++++++++++
>  .../bindings/misc/xlnx,axi-fifo-mm-s.yaml     |  93 ++++++++
>  MAINTAINERS                                   |  13 ++
>  drivers/staging/axis-fifo/axis-fifo.c         |   3 +-
>  5 files changed, 318 insertions(+), 142 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml
> 


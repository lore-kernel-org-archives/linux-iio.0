Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336007;
	b=t9m5PuNCcym2ovEGbBgWAskafRUFrUme/RIpWdin+qg8hX2ZpYcvRbX3tac4YVs+joAs
	 zLIBxCIvQWdCauOS0nrWJKGq5m/RFI4nfvwatUDQau6fL2DEn99fDVAUFPe8F3w8wGhrf
	 o8cgS1YqO0BMjUX67pVX97QJnSPYVBKf7VuJQYRELEoLtY3aayHaBMyaAQ0k1fFFQh7SW
	 UxHox+9v0glqmBlpdiAuHNOESaHDUumhezRSMe4LRxYQ2V32bEupwKhsKHOHy6K2wjJGh
	 OViYImAwfwR/1KaFCmQSS2sTljtyrWHF4yxL1PVeeyMeZ+SchE42SS39Ugd2hJOhRTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336007;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/kF0J6XaXASnOq48tO3fs5WWuq00ky1c0poHe18oFnc=;
	b=OhKhpFBuQvwxxe5RFV4A2sCR7ZtO9EwS+1vTOpeQvZmHJp8wNrXqU68CJ/fzvog7oi4i
	 gbe1E8QsIvHhtKBpMqFOHUK76xMjyhW5ZZ1p9vJ0dy7fn2hhaPwzO9ygMJOuZsgBLfefE
	 +4VGaI+3CQe7VGrUneUBT2J/Fow2a/To9eEIch5hHjtHW+WjUQksU9P5ScTfYwtomF2+D
	 y8K+LRDKNOCIuE/IzCtow7AIcf0j+ILyQeasReWNdXwSvlECNSBgHVKJcqcS2Au8oeMDu
	 rRQdb1yYmKztfPVowFuHzVffbpaULUteyj+YaKryQ1SBCzRftKGfAETXQQ6h8sKMQFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYBOurZs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9D60A3832;
	Tue, 10 Nov 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYBOurZs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DD71F0089F;
	Tue, 10 Nov 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336006;
	bh=/kF0J6XaXASnOq48tO3fs5WWuq00ky1c0poHe18oFnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MYBOurZsTMWCYsEmMX/SidrIn1nJumfY6pFfWNaYZPksqtHzenwVI0OgN4QampdP3
	 PL9vkKgMOkO1j+ILq4f1yIwE+6/ylnBuxszxJOIpT74wltt4cv23KmwN/k8e0BfKMW
	 aoDE/lzD9WD6L6sWgEmTWKYILTkovwjPcCRtBOBg9hS8HNXzUQ6pV0fkS63NP26Vqf
	 d0deg2O1Dr6mmF4tvdZ+nJ2A/OxR2OJLXDxl849/WS7CxM2g5DS3rIbZrXcMGTnhQq
	 bvXhFbVDlxjG15g5gND6XEBOjeCcwuUx2nJtxAd8Kad6EaQ6btUdH5Ri+ijiitOLkk
	 KgtDpdvCrJMWA==
Date: Tue, 10 Nov 2026 12:40:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: michal.simek@amd.com, lars@metafoo.de, linux-iio@vger.kernel.org,
	nuno.sa@analog.com, git@amd.com, pramod.nexgen@gmail.com,
	linux-kernel@vger.kernel.org, jic23@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	sai.krishna.potthuri@amd.com, andy@kernel.org,
	dlechner@baylibre.com
Subject: Re: [PATCH v5] dt-bindings: iio: adc: Convert xilinx-xadc bindings
 to YAML schema
Message-ID: <179433600251.1216259.14459896909936066829.robh@kernel.org>
References: <20261107134955.1423727-1-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107134955.1423727-1-dileepkumar.nagavarapu@amd.com>


On Sat, 07 Nov 2026 19:19:55 +0530, Dileep Kumar Nagavarapu wrote:
> From: Pramod Maurya <pramod.nexgen@gmail.com>
> 
> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
> from the legacy plain-text format to a YAML.
> 
> The new binding covers the same hardware and compatible strings:
>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardblock)
>   - xlnx,axi-xadc-1.00.a  (AXI softblock)
>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
> 
> The xlnx,channels subnode retains its legacy name (including the comma)
> for backwards compatibility with existing device trees.
> 
> Move xlnx,channels under properties, as dt-schema now allows node names
> containing a comma for long-established bindings.Constrain the reg
> property of the channel subnodes to the valid channel range of 0 to
> 16 with minimum and maximum.
> 
> Drop the redundant "type: boolean" from xlnx,bipolar, since its $ref to
> the flag type already implies it.
> 
> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> Co-developed-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---
> This patch was originally posted by Pramod Maurya.
> 
> Link:https://lore.kernel.org/all/20260515075736.172172-2-pramod.nexgen@gmail.com/
> 
> I will be maintaining the patch going forward and posting updated
> revisions.
> 
> Changes in v5:
> - Simplify the commit message: drop the mention of automated validation
>   and remove the dt-schema PR reference
> - Use "hardblock" and "softblock" instead of "hardmacro" and "softmacro"
>   for the Zynq and AXI XADC variants
> - Drop the clock description
> (Comments from Jonathan Cameron)
> - Drop the "|" literal block indicator from the clocks and
>   xlnx,external-mux descriptions, as the formatting does not need to be
>   preserved
> - Add "default: none" for xlnx,external-mux and remove the sentence about
>   the behavior when it is omitted
> - Reduce the examples to a single one. Remove the ZYNQ/AXI/UltraScale
>   origin comments and the two redundant examples. Add xlnx,bipolar to
>   a channel in the remaining example
> - Add Sai Krishna Potthuri and Dileep Kumar Nagavarapu as additional
>   maintainers in the binding and the MAINTAINERS entry, alongside
>   Lars-Peter Clausen
> (Comments from Sashiko AI review)
> - Constrain reg in the channel subnodes to the valid range 0-16 with
>   minimum/maximum
> - Reword the commit message to describe the valid range constraint
>   (minimum and maximum)
> 
> Changes in v4:
> - Move xlnx,channels from patternProperties: to properties: per Rob
>   Herring's guidance (keywords.yaml: "Fixed strings belong in properties")
>   This requires a companion dt-schema update to add xlnx,channels as an
>   object-type exception in vendor-props.yaml (like adi,channels).
> - Fix reg constraints inside channel subnodes: remove items block with
>   minimum/maximum which is invalid for cell arrays per cell.yaml; the
>   valid channel range (0-16) is documented in the description instead.
> - Remove redundant type: boolean from xlnx,bipolar; the $ref to
>   /schemas/types.yaml#/definitions/flag already implies boolean type.
> - Fix patternProperties regex for channel subnodes to "^channel@([0-9a-f]|10)$"
>   covering all valid hex unit addresses for channels 0-16.
> 
> Changes in v3:
> - Move xlnx,channels from properties: to patternProperties: to satisfy
>   vendor-props.yaml meta-schema (reversed in v4, see above)
> 
> Changes in v2:
> - Fix patternProperties regex to use lowercase hex unit addresses
> - Add allOf/if/then conditional requiring xlnx,external-mux-channel
>   when xlnx,external-mux is "single" or "dual"
> ---
>  .../bindings/iio/adc/xilinx-xadc.txt          | 141 ---------------
>  .../bindings/iio/adc/xlnx,xadc.yaml           | 165 ++++++++++++++++++
>  MAINTAINERS                                   |   9 +
>  3 files changed, 174 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


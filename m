Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEE370D6E;
	Wed, 12 Aug 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499664; cv=none; b=T5Dev/5HFQOED3GfIntoYw5B5ly437H49Oj6zQMUxaZx8VD4ogugWFYeBUV6vYKzPg/kIpNw7tF257QQC77Tq5q/uAWPkIgMS42LikKM4vFJ3UGzF/D/bpCN7w2r1r43QgkG2kFtuQH/fsQyOUiV2z8NSPBPxGfw3IhDG5GrSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499664; c=relaxed/simple;
	bh=av2488W9kRObFIvUZ6n31XOm0cOm/m+ecUp0HroNpX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxF0kAS0YCkhOuLhZAEq38btbKF66ltj1S1kcuBSA795WDrGdXOediy1+AuRb8SoxcCd2NRvZ0qi1qFzLew2gT8UmMZGqCuaw/VLREw0SpmmvP/rmPQSpUXsauebY7BVLmCI2MCfN8WtPZ8ScDRuDyTbP75xe5/LK+VoUOQetMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnjXkP1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnjXkP1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EDF1F000E9;
	Wed, 12 Aug 2026 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499662;
	bh=StXTIZ2Cs7/VOPshaK+cfw04FL633eBiY6Nb1shOktw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dnjXkP1P6H/7B0i1DdtoncMI6CIGuDDmfCXuJ52DQfS053HpiZz7+f1PoJme8FjLm
	 KTG3/OYUU+7tj2RObpXxq1NJf9ZJFPyppN6iF8J7+YakmpiYsuO9BYrZ//PhEorYOn
	 Vv6N2FLi8AKInpEdcCRig6pfFyL7230CFVn8jayYL/vZogqzvaHUwcHr09QswC0gQi
	 Ee75JYINsietH5nNXFmeDplTDQyiXfd4PSE3npKC8JZpUtncxPfkdaQrgIS/1j+O3n
	 KO5gNih1L83oDiG8xRTgA8lUpSR3aTp6uFNgKk97RVv8IAtp8UxUr7K9xoCI7bdF+m
	 jLZlxSNub/gww==
Date: Tue, 11 Aug 2026 20:54:21 -0500
From: Rob Herring <robh@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: adi,adis16201: add adis16203
 compatible
Message-ID: <20260812015421.GA498537-robh@kernel.org>
References: <20260805102224.3547-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805102224.3547-1-shehryar.amd@gmail.com>

On Wed, Aug 05, 2026 at 03:22:24PM +0500, Shehryar Ahmad wrote:
> The ADIS16203 has the same external interface as the already
> documented ADIS16201/ADIS16209, for the properties covered by this
> binding (compatible/reg, the DIO-based interrupt pin, and VDD
> supply), verified by datasheets Table 5, Pin Function Descriptions,
> in the respective Analog Devices datasheets. Some Auxiliary pins
> differ (e.g. adis16209 marks a few pins DNC where adis16201/adis16203
> use them as AUX COM), but these are not represented in this binding.
> Add adis16203 to the existing enum rather than creating a separate
> file.
> 
> Tested with checkpatch.pl --strict and dt_binding_check; both pass
> with no warnings.

This is assumed, no need to record it forever in the commit.

> Three prior attempts to document this part are visible on the
> mailing list, all as separate files, each redirected toward this
> existing binding approach instead: Saalim Quadri, March 2025 [2],
> and Sheng Kun Chang, April 2026 [3]. See below for Jonathan
> Cameron's earlier, related attempt [1].
> 
> A richer version adding reset-gpios and a second interrupt
> (interrupt-names: dio0/dio1) was proposed by Jonathan Cameron in
> 2023 [1]. I tested the same additions locally for all three
> parts; checkpatch and dt_binding_check both pass. It is not
> included here, as it hasn't been verified against any real board
> dts file, and none in-tree currently reference adis16201,
> adis16203, or adis16209. Can send that as a follow-up if
> wanted.
> 
> Link: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230129155602.740743-13-jic23@kernel.org/
> Link: https://lore.kernel.org/all/5390c973-6a92-4de8-b00a-cd62af347ccb@kernel.org/
> Link: https://lore.kernel.org/all/20260402-fair-wakeful-okapi-3c6dba@quoll/

Thanks for the history. It should be after the '---' so it too is not 
recorded in the commit.

> 
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adis16201.yaml        | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

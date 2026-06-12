Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5AB3AB47C;
	Fri, 12 Jun 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255230; cv=none; b=IDALGwacVKiLyFq+NtgEqD1eKxqpiKNMr0c0pvJ6v9bZHsMtisTGfMPfcc64gMjcm/X5tk97dmxaB/nXFwJ2Ica1e6Q5VMHN6HdLZCxfT8PfYyunJTiSnxPRfP5T3i5IBnfZJ3l50YKuMQU9dECetrm+6wAEEftpIe392v5IRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255230; c=relaxed/simple;
	bh=jz3RpjM8LIliaOB4qEdXmUbxdvP5m57QHCy/SO299V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATnll8LJGm7hWqDkn/CqYq4ElrHnBpjuDMxjKyOh5ccYAQKV4ur0KjkCJxIY25MzqEn8T7Wv4dV5ZBy4CiQyKsZoDEKhrcsD8FpoedQNyNsHfivvYsI5643kg1EsAZncg/ekpuAGDAUZENoMbKAtj7WMh/9mzkVAYSevYALPFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTeZSuyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTeZSuyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2F71F000E9;
	Fri, 12 Jun 2026 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255225;
	bh=jz3RpjM8LIliaOB4qEdXmUbxdvP5m57QHCy/SO299V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OTeZSuynCGpSJZoi4pMYJzzS2G0YQU+NGTGQIFES6m0efWi+bDQ1OdGrGn6VNgJZC
	 rW15LI1hPcbcXJFMdqzgAT9Y+/DpGzzzABuC5u6LgJXfBOJb4j1o+nGlvUqhEea12F
	 C+ncKyBzQ3f4XtKHeuM4vY4cjYZK8YJCS3jjWg37+jyL9QCMv1sFJN98JrK21Zzc9t
	 OeauY/xMWvpfUrBwVCiUew8CmlfJEx+AsbXKDjm/o+xTbr7nGVAoyWukrs0CH7MfVe
	 DYsJte8OFY3mgN0g3K/cydmo/v/+6v39TvjBNe3uLjETNOqsvvPnxevzjR06F8eNby
	 gzsPNLAB5cs7Q==
Date: Fri, 12 Jun 2026 11:07:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linusw@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: st,st-sensors: remove lis302dl
 and lis3lv02d from deprecated list
Message-ID: <20260612-mysterious-amiable-moose-0d64ea@quoll>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
 <20260611154105.3727-3-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611154105.3727-3-shofiqtest@gmail.com>

On Thu, Jun 11, 2026 at 06:41:04PM +0300, Md Shofiqul Islam wrote:
> st,lis302dl-spi and st,lis3lv02d are being given their own binding in
> Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml. Remove

This is not supposed to be a separate commit. Removing compatible and
making it missing from schemas is not a desired change by itself.


Best regards,
Krzysztof


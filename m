Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFF1F151C;
	Tue, 21 Apr 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783449; cv=none; b=XXfK2jB2EXogUJnyV3/yRN4S+xGFfUeCmT3JPqFQaGUDBq4zUpvg8wgc3O2OEDSa7Tc9serks43lTxW+YwION728RcK/XyQ66Oh8MY5khzOEUON9K0xl/sFBl76b5Dd9/GqutsrBNaDKfV+zc6AmkSCQe2JUK48YlxslwOxqDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783449; c=relaxed/simple;
	bh=HcsHWLjszcRC2B2e0v8iOr4a2qTwSQ8ZSEtPCq29cf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfTvGWhTPev1FD11uOnUBZX+9eSqDntyim/AQbmWpWkyFaatThULm/sKNWuEkgivAYXKVtUebpQA1iGNK2ufx5efkvj78LXICZ3TvTzo9dk1J+kWh08rvQcFyJvWVc/evqOL9Z97JhpbTlAXOyXaVj5VONYnw60o/KF8f/TdQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLYxpyTJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLYxpyTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757D1C2BCB0;
	Tue, 21 Apr 2026 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783448;
	bh=HcsHWLjszcRC2B2e0v8iOr4a2qTwSQ8ZSEtPCq29cf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vLYxpyTJH3VjAnllhNl3C62E+wpaU5LK/tSDHuGgl4X0ZvMC3MQsPbvd7X/WorGpR
	 mrvvO40IplUrvRsp2XZ9czxu8CaCnTqwUnFlDpcA0GjTc8Zr/pZ0ujQlPHQf47AFf7
	 0xGqlcJPrATC5xvcUZQyZsrNrYWP+OE6tl3V1sQpxqFGT13i3HA2ZtyqMPApMtLXrL
	 LvQTe3GkieQqT2VADXJ0amijmaHLlhzWPg5ii2JGhjZDFn2MDhJVlewJEwHTLeqdg5
	 aqUj8kPcKvofJjidEJSqBo/kQ+AMFkjyh7kRb4yKBml7RKURON4DiwamdrbwJqR8rG
	 W9bjxK/6Qs97A==
Date: Tue, 21 Apr 2026 15:57:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Minu Jin <s9430939@naver.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7816: use sysfs_emit() instead of sprintf()
Message-ID: <20260421155720.7c4a8474@jic23-huawei>
In-Reply-To: <2026042032-unbeaten-magnetism-677c@gregkh>
References: <20260420112720.1662703-1-s9430939@naver.com>
	<2026042032-unbeaten-magnetism-677c@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 14:30:05 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 20, 2026 at 08:27:20PM +0900, Minu Jin wrote:
> > Replace sprintf() with sysfs_emit().
> > sysfs_emit() is preferred than sprintf() in show() functions.  
> 
> For _new_ functions, not existing ones.
> 
> > It has aware of the PAGE_SIZE buffer limit and ensures safe buffer handling.  
> 
> Are any of the current usages incorrect?  If not, no need to change
> this.
> 

I wouldn't mind it if part of more general cleanup and modernisation, particularly
if that was touching the relevant bit of the code.

Before sending a patch check if anything similar is on list.
There is one other near identical one I rejected and a more significant
cleanup series that is undergoing revisions...

Thanks,

Jonathan

> thanks,
> 
> greg k-h
> 


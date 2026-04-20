Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7A3A5E82
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695288; cv=none; b=oCBmM2M0KU/9HCu2rUWesMrwY5C4FqQgPxL02O8ZDMfoE/i+Gu858ONBKDFoX5uU+8VIMijdfC0CTTTNIaUfpIx8jau8Wuvg6jjhrRfohUPbIqXGTjRQfX6IQTpJxxc+Eze6J1uFY4Vr+WDnozHaq8ISmfHNctdMxvZzC9b0soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695288; c=relaxed/simple;
	bh=VXe9F367lM8oLOfiXXkzeEBwXcWi+junlZUrinVM7p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsrjXyQFChRLbgvrONC3Bo6jXlz4jZme6oufBiolasCwoU/Ywwf4blgL+yKEW5EgC2VZbOp0x9ThxCj4H+l3SxIJUYYuA4O+raPiMMma0ojZ6jt6UO28w/MjqpPJqBFcoI7Jox5ClT0f8/JWtKitYYZZEwnhfh+Djx0RgXODIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpSc4TiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpSc4TiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E6EC19425;
	Mon, 20 Apr 2026 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776695288;
	bh=VXe9F367lM8oLOfiXXkzeEBwXcWi+junlZUrinVM7p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpSc4TiQJZgn6IVzejVFTzv0R0KXPKsbpfm8zqjqjk7aCG/U4i0UuypQlJQ+8mLSX
	 koT6wIrocXLoANKqwJZ6rU75sBOcmaoicugfC6GNYPJ08JA1EieYwxJkFPGnUUf0b8
	 qWaPkiQidGaMGwXRcwKj+YkNRGXdp8DNaHzwgmDqeU0GkHpwWbCi+W9EaN3FesMJKX
	 861yhJ8n9u5LVO8s7DdZ/03dbpZjPTGdh8jGRfepKj0HgkEynMi9qQggfBs6HJo2OX
	 +0P0FXftpSpxbLdXGzeLmMDR/hDo2QxUA/hJZf/24tKxvUc6RBc52jZh4Vm/zkX7g2
	 NKRhqQYNBQuIQ==
Date: Mon, 20 Apr 2026 15:28:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chuang Zhu <git@chuang.cz>
Cc: Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ina2xx: add INA236 support
Message-ID: <20260420152801.34e6844b@jic23-huawei>
In-Reply-To: <ef14ecd8-b35d-495c-a4e1-b6ae9d81e7a7@chuang.cz>
References: <20260315182304.613783-1-git@chuang.cz>
	<20260408155520.GA2256298-robh@kernel.org>
	<ef14ecd8-b35d-495c-a4e1-b6ae9d81e7a7@chuang.cz>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 23:21:59 +0800
Chuang Zhu <git@chuang.cz> wrote:

> On 4/8/26 23:55, Rob Herring wrote:
> >> @@ -1082,6 +1117,10 @@ static const struct of_device_id ina2xx_of_match[] = {
> >>   		.compatible = "ti,ina231",
> >>   		.data = (void *)ina226
> >>   	},
> >> +	{
> >> +		.compatible = "ti,ina236",  
> > 
> > This is not documented. Please add/extend a binding for it.  
> 
> There is only a devicetree/bindings/hwmon/ti,ina2xx.yaml, but I only 
> added support for IIO (no HWMON). Should I extend the existing binding 
> regardless?
> 
Good question. Given no DT maintainer reply (most aren't in +CC)
I'd go for it and see if you get push back.

J
> Thanks,
> Chuang
> 
> > Rob  
> 


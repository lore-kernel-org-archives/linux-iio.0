Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B017370D54;
	Thu,  2 Jul 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019457; cv=none; b=u8DuZAaxPlpEpLD4rMsTIPIenWDDV8IgIUOQpZAzITWQ13Qndldg5z/yEdinBuDxaz9gN5WfS0YsBOqkWO5KKRKB9vR4i2FdE9WcBtK+8lr7gb1ebQuPfYDAqUGomxDuS47Xin9t9A2AUu2pbOB6CWKfN0kvAcGSIHomDJsXhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019457; c=relaxed/simple;
	bh=I5xwFfXJL/F23jY/UVU84QhVfYWMYpavgCY/6SVcqsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8bR26s53w5rO7xXkN2TSRJKCErh5uSpFLilU6IhgCUuVXi/K7Be3kE/FcfGgI9mrCFwJTV9vGNCVTtX0JTxx+tFCga+Z1yiHPDTYfIE9RUwmtwffZ8v5Ibob1TdvZvviFOECIF3IcjVIY97RiMF6eYq8yi9qffRX73GocHJd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8IQYceY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8IQYceY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD1C1F000E9;
	Thu,  2 Jul 2026 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783019455;
	bh=oTonvux7NCPyRZ3T4vDun5Mjs1cckhZark104izI2yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l8IQYceYuxBa80cAE/zYNtcw1EBS9gACjME8RB/t4FvoZm2tiSY16c1TSO7tlGCWH
	 agggFSeR5rB46NWN7LAXudhWJQeh2FxoiXl8/kzvD4kEQfLCGi0RbnIhnoh383aWQW
	 MTL4aCeIFkGfTZbd9cC41lw/xp82SdvJl0AwIrggOJ33GrK6QcAwolN1CrKrxBS54Q
	 n9rcgtUDE4dShh90+yf+NuUOGh/fs+C1I5rX5flPNCnPaS4hOu2mKUn6HmQuMS/NQL
	 PRMgBt8EU2VlRR+C1xdCuVdaU55r01RytABYnQwrwUfGFgrQXAQiskfBPCwAKdoNXf
	 tVI1D+g83Pmqg==
Date: Thu, 2 Jul 2026 20:10:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <20260702201049.164d939f@jic23-huawei>
In-Reply-To: <544fbdef-268d-49cc-ae9e-b18907d9382b@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
	<20260625-iio-adc-ti-ads122c14-v2-8-ceb9b0b561cb@baylibre.com>
	<20260701212019.12757df3@jic23-huawei>
	<akYs-QgyjN-nmjq-@ashevche-desk.local>
	<544fbdef-268d-49cc-ae9e-b18907d9382b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 09:18:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/2/26 4:18 AM, Andy Shevchenko wrote:
> > On Wed, Jul 01, 2026 at 09:20:19PM +0100, Jonathan Cameron wrote:  
> >> On Thu, 25 Jun 2026 16:55:10 -0500
> >> "David Lechner (TI)" <dlechner@baylibre.com> wrote:  
> > 
> > ...
> >   
> >>> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> >>> +		struct ads112c14_measurement *measurement = &data->measurements[i];
> >>> +		struct iio_chan_spec *spec = &channels[i];  
> >   
> >>> +		if (!fwnode_device_is_available(child))
> >>> +			continue;  
> > 
> > Also drop this dup check.
> >   
> 
> How is this duplicate? device_for_each_named_child_node_scoped()
> doesn't check this.

It is convoluted to show but it does (now)...

Ultimately for dt case it calls
 of_get_next_status_child(node, prev, __of_device_is_available);

IIRC that didn't used to the be the case and we had iterators
for available and not available both for DT they always meant
available and more recently it got cleaned up as the number
of places that need to pass non available nodes is tiny!

Jonathan

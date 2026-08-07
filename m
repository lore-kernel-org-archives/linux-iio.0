Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0132A3C9
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127587; cv=none; b=VeOHNd5huXw/gkNn+XyFDAYi6o/37rdC3aGnJmlJM1w/EDqxgCtCd4Y4Nxx6Sq0qkMr14auhLai0bVe0edLeXUFnF+raeWsY0uZMjeqGhjIJjdgMfnKYx09VBF1IIXYPFa9gFcNE3PGXnNk6z4pZPJfZueR9w18lyGfNkBsdD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127587; c=relaxed/simple;
	bh=LVRpvRWQSaxHfSgYe3MtbFfNAnOMtlsZRIWS10Dv0GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo5OAjX4ZzvDIGqRI+L51C8xWq8j539UaJG6PJhcOQnslCQHbnm+x0XCcX3UH+2e2IfWylOb4p021DS35Et0bu4PKKx7V+GmohU/DQPYRzN//uLFaZ/2r22/fIWMIAItAgK2ipaTZ8W1PKDSdyJA5DazSNVeMqWar3tHszjJin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXQxGHOA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXQxGHOA"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e54f8c051so197322585a.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786127585; x=1786732385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCdCLUuBP8/CkfxUK6b74oN1gwbSsaQEa9gHG9eOXxo=;
        b=ZXQxGHOAbmMIHVU/Yu7D4PNpE+Ee56ASOWUid5PZeXt2kis9luGCXXULW6gHNYSqap
         9f/fI3A9q7/MGwWOwAFk2ojXbbCU/uGVDBi6fIfoROv89Qm6f5Ibq5hULAlMAwAtxFtn
         B5O16ktooqjyYXKgiiEQGe5sY/vhfbg0csKGHJX4ijtRcchdgerYNY8C39Aj3plGA3Qz
         vCdoDrB8Y7o5P9ZW//zB12pv8LSk1iFBfm0zTLJgosY+K/2HqFfT747ArhhMBcG2e/w9
         bB6TeCWaLesmdd6kbb5OHQOr5V8CFOLtzPx+iAZTcq4KNVxq63mRrNtFD20q8WGDK6p9
         jz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127585; x=1786732385;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCdCLUuBP8/CkfxUK6b74oN1gwbSsaQEa9gHG9eOXxo=;
        b=MTE0q6l49fHQVUjYgkEP4kFsO3yIwdL1ON/RMk/c3wnlj1NzRpKjUuIytMyVao8LpY
         tfpRpWxmE5eYLqJfdbfmzOHoMjh0RcEqhfwMaL+MIqfRkEJdV0ulS2NPEMs2jv8a+kQE
         cmy1i0lqCpVkq5Hipxh2tUnZnz7m14QRKnBSvzUz3K5FXbg2QMNHVxA5ZawI1nFSeO+K
         GBv7ihosA28edbteE0c59JMBVmGSz7ETQ5evpqAIUz/ixviOKk3NlIBuzDyEU3I1zms6
         K9DCBzDISzgBe1vR9SqxnJ/vOy7dYHSXSPgLYpFS/ide19lWnNVQbHlfRpqXF7IQPr75
         sPiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7I3OPC+/QcEQOAw3IrlE7oJzLR6Xipkl3N5wiBv0sGVS2VRwMVqTMcY53cOEqiGSSTfh2EwNUpsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXx0aLNPP6e3PTds8sgzNMQsZWB1dCfqBaR09jqZamDFDO7Y8B
	hJMca4b0Pwxf9xUd3FUoN8s4aT6i5J4uzn5hj+Id6mYmjxOZCHDRx5tG
X-Gm-Gg: AR+sD13Q0IyBt8HGXqlgDo1/PeB94Uu50iTps7PI4K/GoA/GR+Xe/gpK1ixyisNnZN8
	QkCTamGlQ+yjH6x4nzJ8Ajf+uRDdarfG9H3xeCeRGU4I9iNHOVYN9fF5BzzM3rxdvtmideCKoUX
	Plu0TOxS8iFydv6fdscaR6JvTe9IMr87Dz7SgY4XiYG+18qcZZXyaUUPAEuf/v+DUUaQcQDW5wJ
	PNwg3YmjUCZdDM1TBv6Qq5D5NNGdURPqY3+jGHpVIdddTTEA2qGfVAVJkRDSwtSFVU6hi0rhBwM
	mrNYBz/ltd8Poo8CFzlYM8RGoopzYrToNxDTfvSPgON7Mu4qsrsDkFbjOQ4aleKrmozL0YhPE/s
	jHuVAXmQm9+prnf4I0Z0qw1RN++19Z7ZxJ+VHf4HgNrms97AS0dfHvqi84Af4pLZLkmbXOtS1bW
	0crLd3vlcg+T9XGKCeGQRpylxNO7yEudsAZCi+jJb6WzRWGCpekzYTeut7yLhAgbLOCIs2L7Gat
	A==
X-Received: by 2002:a05:620a:2614:b0:932:deb4:7788 with SMTP id af79cd13be357-93648fc7072mr2802915985a.2.1786127584946;
        Fri, 07 Aug 2026 11:33:04 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e229853sm206057085a.28.2026.08.07.11.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:33:04 -0700 (PDT)
Date: Fri, 7 Aug 2026 14:33:01 -0400
From: Louis Adamian <adamianlouis@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <20260807143220.409fe4ec@louisarchdesktop>
In-Reply-To: <anT8Qs1ga7ayvtWZ@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
	<20260610020458.104818-3-adamianlouis@gmail.com>
	<aimvBvJp8CsNKlPU@ashevche-desk.local>
	<20260611151026.4abf8804@louisarchdesktop>
	<aisNMmwMREF7Iga6@ashevche-desk.local>
	<20260805130651.4aceb71f@louisarchdesktop>
	<anT8Qs1ga7ayvtWZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20260807183301.jojTkoO7qAdG4ooOhaI6oqPjKBj8ters_AwSWjZQZt4@z>

On Fri, 7 Aug 2026 00:27:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 05, 2026 at 01:06:51PM -0400, Louis Adamian wrote:
> > On Thu, 11 Jun 2026 22:32:02 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Thu, Jun 11, 2026 at 03:10:26PM -0400, Louis Adamian wrote:  
> > > > On Wed, 10 Jun 2026 21:37:58 +0300
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:    
> > > > > On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian
> > > > > wrote:    
> 
> ...
> 
> > > > > >  struct ms_tp_dev {
> > > > > >  	struct i2c_client *client;      
> > > > >     
>  [...]  
> > > > > 
> > > > > Please, check with `pahole` if this is the best layout.    
> > > > 
> > > > I will correct the packing on this per pahole's finding.    
>  [...]  
> > > > > 
> > > > > Can this be simply embedded into ms_tp_dev (and copied there
> > > > > if required)?    
> > > > 
> > > > Copying in ms_tp_comp_consts provides no benefit over
> > > > referencing the pointer; the values are per-descriptor, not
> > > > per-instance and never modified. I'll keep the pointer (same as
> > > > ms_tp_hw_data).    
> > > 
> > > Okay, let me ask differently then: Can we use the same data type
> > > in ms_tp_dev instead of adding basically the same fields as in
> > > ms_tp_data?
> > >   
> > Sorry for the very slow reply. Yes, for v3 ms_tp_dev will hold a
> > single const ms_tp_data *data instead of its own hw and
> > comp_consts. This drops the duplicated hw that predates this
> > series. 
> > 
> > One thing worth noting before I do that: ms_tp_data is currently
> > private to ms5637.c and will need to be moved to ms_sensors_i2c.h
> > for ms_tp_dev to point to it. I don't think this is a problem; it
> > matches how ms_tp_hw_data is defined now, but let me know if you
> > would like to avoid it.  
> 
> The pointer may be opaque, in that case it's not needed to be exposed.
> 

ms_sensors_i2c.c dereferences both ->hw->prom_len in
ms_sensors_tp_read_prom and ->comp_consts in
ms_sensors_read_temp_and_pressure, so an opaque ms_tp_data would require
passing both pointers as parameters. I plan on moving ms_tp_data into
ms_sensors_i2c.h, dropping the original duplicate hw, unless you prefer
otherwise.

-- 
Thanks,
Louis

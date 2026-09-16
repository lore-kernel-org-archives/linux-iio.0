Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD235F16C;
	Wed, 16 Sep 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578501; cv=none; b=kd/jQL9n+Wya5lCnVU4QfDSj1n5YP40lkmqKHcuCD1MjbzPwN5toJyWtMtA01exGGIeW8p1DDJV6wauaKqgwX9Dst1Ik7obikl/3lz1obN0jaLtSTgphPGYmgYUE+ooCK5rK4dWX3kT9Reo8J24XW/3ZM2F9DFvqrSDJtejKOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578501; c=relaxed/simple;
	bh=g18Yx4SIRS0gtdyLUNjh7JGNXMC/sfGYlojgNlcM1yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhMe5XS9v2/Er0by8G07CJGLcX+myex+rKeJewXaw0Sw2h+mdw2pvHo0msKoa/AAWe0aCfZE8ZSSOxL+wvceR/JlH0nqfhBn2+rtTwl3VzIRuaQvE6cfaV1JL4f92Zqk/IYtyUM/nCJSxRP+TUidDwwrR/nSjZ6xzJUmAuqG75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QJqQezZH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJqQezZH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=a9gqJai3hb7bGxNh7caRWuHo/WKOV35MtEpKIiaep5A=; b=QJqQezZH7/sCsvRAmqyYkNUOiW
	cGZprFheaGqU4PegPL/UZX/GIu1U+M9mpSiDrZIlLwcXNNVFUip49JBpEPrYYfEEj15I7DgwmywhK
	edhBfYcxVsyd9ZrxzXSu76uK0KMo7HTDOkeztAb5GsqXR0+vuPgcwrd43+jw/oumIvYtRZkvsVSF0
	ZzwaFXoexO5Vj/g5Fvmyrk8SnCfGiD6auuK9D1knQHPoY3BuibEDT5Xhi4YnEOoWpusdx3rzS4LBo
	cOracg3vtEM06H0sP0zeZbtG3kdmALNZobeqC++Etr1EemHZgKMgVXChENGgYZqu+5Pkuq7D4f6ef
	nokMVM5g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6t72-00000009pl6-13zA;
	Wed, 16 Sep 2026 17:08:00 +0000
Message-ID: <4a7ff403-d223-41ba-bc4a-cd73680fff37@infradead.org>
Date: Wed, 16 Sep 2026 10:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: backend: use literal block for commands
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20260916054924.2052572-1-rdunlap@infradead.org>
 <aqpFtj_yYBcznhDT@ashevche-desk.local>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aqpFtj_yYBcznhDT@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 12:31 AM, Andy Shevchenko wrote:
> On Tue, Sep 15, 2026 at 10:49:24PM -0700, Randy Dunlap wrote:
>> Use literal blocks for 'cat' and 'echo' commands to separate them from
>> the surrounding text. Otherwise the lines run together, without any
>> clear break before or after the commands.
> 
> ...
> 
>> -		Directly access the registers of backend Y. Typical usage is:
>> +		Directly access the registers of backend Y. Typical usage is::
>>  
>> -		Reading address 0x50
>> -		echo 0x50 > direct_reg_access
>> -		cat direct_reg_access
>> +		  Reading address 0x50
> 
> Then make it a shell comment style
> 
> 		  # Reading address 0x50
> 
>> +		  echo 0x50 > direct_reg_access
>> +		  cat direct_reg_access
>>  
>> -		Writing address 0x50
>> -		echo 0x50 0x3 > direct_reg_access
>> -		//readback address 0x50
>> -		cat direct_reg_access
> 
>> +		  Writing address 0x50
> 
> Ditto.
> 
>> +		  echo 0x50 0x3 > direct_reg_access
>> +		  //readback address 0x50
> 
> And correct the style of this altogether.
> 
>> +		  cat direct_reg_access
> 

Agreed; will do.

-- 
~Randy

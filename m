Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042829;
	b=QtvqV0kt48/99pxrRaT/3nPE4Yng6BDLBQzFiRny6ru+2jdLdTID73IKKSYuanU3v4wz
	 v32pkPANupdd9FvE5WsdCY3FBVPvIjxOZktUnUDyN9HJ9vazg8i7xDdMCouAvhGXQiaxJ
	 xjOxCwVxrlHf0PkU28RE+NQ8A8LGnG0QHCsSZA9F6bVWuGwxha3gr58R2aWrjFFZ6zQIu
	 WsWEoZbxtTe7XfdKTMbXeD62vKQYOy0QtQZWpQdNSF/zLds5gBQ7L62dGZi5G0YHfqk5c
	 aG0Z8gxc+yp3RHw1cDkZ+HBWyFrWkD/7AGVBZsh4WiJBlL2hON47WoVk79w7DMwYw5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042829;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=LcGUIxJ0hhWwJBANgRsmsDcWNEnQenUxD/N5yM1KEfM=;
	b=ce+fykWXqCwqCYOLe883dXZNTsFsGotHXES0EI9qsFCJt9gkQYoRiP6vFka9c4xHzcuQ
	 KCQmHSOa+9c0tVqr/vMimsrzpZCbgVV3FdFyKCLQEQr8DIcbQH8mWgI7zZ74HwhCrSRKi
	 tWvCzMvjfa0LWu9pvxYycerHz4kBtUAP7MU/V51YEtYm2wWIcU7aKTmm3ghJz8uiQYmWF
	 rykmInWJ9EaLrL6x5E7K/F5Pz1ZBgEqNNoKWT76UWTBV5RJ74QNuAjgx39IJ2WLLRTo5s
	 cRVVFzOVDZrMMHkNHxshcfHotlA/ezXw9I4gr7QSHm4FoXp0iaZI1BsYujxqC1YyQcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=l6IhFjxb;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D2606A320
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 23:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 334D2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=l6IhFjxb
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id Tla6x98mjAR1iTodbxzkLz; Wed, 18 Nov 2026 23:00:23 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id TodaxPYsj8cn4TodaxiXM7; Wed, 18 Nov 2026 23:00:22 +0000
X-Authority-Analysis: v=2.4 cv=Qrde3Uyd c=1 sm=1 tr=0 ts=6afe2e06
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=xtVSApEC_Af63HCmTx8A:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=LcGUIxJ0hhWwJBANgRsmsDcWNEnQenUxD/N5yM1KEfM=; b=l6IhFjxbqkEW
	usFNckm0PuJnx6D3jE0/a1aY5IAo3PpzAvw7KShZLOUfkRVno4Lni0blwvnt2OO7ftyK3HXUlZyuc
	FCidRVfOk7o6kjfOjwiYcotvDdE429VCmEL1oVAgikzmoyIzmCvclGTecIERMcjwl8hC9ysLfZRQj
	sY9kTAWaL/FqMHkQ/O9rx2pb6NL9MKudoaN+0dXrVXbtPEg4xQI09v2QkzTbTRcmJ0udV1FIkgkWf
	C28L7rPX28FTx2KsmB91ZxZC0R47/YXJ1M81axuYYM3Sl40ZAIf3e/vwztlRWiP9XqcO2+x15dQDM
	othLraxL6uzql8OB3/hqEQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36386)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xToda-000000049Xm-00es;
	Thu, 19 Nov 2026 04:30:22 +0530
Message-ID: <11a821f4-aef6-425a-8626-1d8641e9f83d@roeck-us.net>
Date: Wed, 18 Nov 2026 15:00:20 -0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Introduce cros_ec power monitoring
To: Daniel Balint <dbalint@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-hwmon@vger.kernel.org, Benson Leung <bleung@chromium.org>,
 Lee Jones <lee@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261106193129.43493-1-dbalint@google.com>
 <20261107010356.39d9eddf@jic23-hlaptop>
 <20261118204532.257423-1-dbalint@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261118204532.257423-1-dbalint@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xToda-000000049Xm-00es
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:36386
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFd5b718NSXzZ3tsLG9KyTr+Ku4iMf+QrnFkyWb9ejB+JplHZcs5TXdIKrke2EGRNKg9yDT3MMxkcRux0urU5ocxvusV/mw6Z4XH0SpWA0JsidbQfdqp
 A6GyYb5oLzXPL4DY6qKrgGZ90UQEXO7B8XnXiPTWUMoUxz/ATzhHjY1ylTduL96L1AjTPlBF9V503nrg5iKoLyXb0pSY/eXpWb/7w90YbWSRz4JYOAbE6uFK

On 11/18/26 12:45, Daniel Balint wrote:
> On Sat, 7 Nov 2026 01:03:56 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Hi Daniel
>>
>> I'm not necessarily against this but when adding monitoring components
>> to IIO the usual question is why not hwmon?  What features are not
>> well supported by that framework?
>>
>> Note historically I suspect we accepted one or two drives into IIO that
>> would have fitted better there so precedence isn't a strong argument.
>>
>> Convention for these somewhat borderline case is +CC hmwon maintainer
>> and list as well as IIO with that explanation in the cover letter.
>> That avoids any last minute surprises!
> 
> Hi Jonathan,
> 
> Thanks for taking a look!
> The main reason for choosing IIO over hwmon is that for On-Device Power
> Monitoring, userspace needs an atomic, untorn snapshot across all rails
> (up to 64) over the same integration window, triggered on demand from
> userspace and read out in a single buffer read rather than repeated
> per-channel sysfs reads.
> 
> Reflecting that requirement, EC_PWRMON_LATCH on the EC is a global,
> stateful command: a single latch simultaneously snapshots all onboard
> power accumulators and resets their accumulation window on the EC, so
> individual channels cannot be latched independently. As far as I know,
> hwmon only exposes independent per-channel sysfs attributes with no
> multi-channel buffer or on-demand trigger ABI, whereas IIO's triggered
> buffer interface is well suited for this kind of pattern.
> 
> CC'ing hwmon maintainer and list to keep me honest.
> 

You could accomplish that the same way many hwmon drivers are doing it:
Read all attributes in one go from the hardware, then cache it for a period
of time.

Having said that, my experience is that people wanting to implement IIO
drivers instead of hardware monitoring drivers keep finding reasons,
so I won't object to an IIO implementation.

Guenter


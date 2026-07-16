Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FE335066
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244060; cv=none; b=QJSbjriLabdYu4DRVGlnUTLP0Vo92lmIZU9m2abHH5PX2MPhJMEhcRFUqVdSsTDF8vw8Lkpb8DAxxPNOLalZ+JR3DyVWUSwWRcov0t4E0qT4xKxhWOUvoJQ+ykumpRwh223X5nIKSbQjH7jiWHVCTVhWsboKiOTu3K+Ub+E3CJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244060; c=relaxed/simple;
	bh=ftw9Kxua3A5FXfCupMJdIbXNcwnLfkeF28nadC29jw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEr2K+nc8NPMaWLK9XixckU6B/cQeZ2m4EsqFWDQYfAD83IQZpLO36ePKbSDitMtP+NW02aAwbQxcVp0LTF/jwjH+CaCt5RbYvaQq4Yfn8OrnyEvfNUmOZD6wiWLztQoIWXTgSWZjUuz4DJtlbCTF/u123OdWtYJGWL0+tBV4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4HXOGNW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIOVUIaS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4HXOGNW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIOVUIaS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNINZd4024512
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 23:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3hkNEDV7VaPjmHO2+DLTkRD6nf1Orhub6TsamTsGDoQ=; b=W4HXOGNW7sITPJKo
	YvYV2xVhaDS3D0QwgNDa1nLZr4dT1f2rQ1W822wzQf24JFfEchPMGpcjiK+gP47N
	uTxvM9trVbbiuQtck1ZKeH92OITqjgQDyYGC7Hx+Sh4KBNJSAiYSvSLly4cS5k9V
	PymNb8yphPTO6id21E7LLKKmcdPvP9RgW9JUk4ww9Unm81XYo6UlYl5aeXV8Kt9s
	sXpudQEraIFbooMznZOGXtvkg5LfZMU4vgi5O6k5Vd75hXD55uHbfXmbf/ctUsYk
	rh2AtQ7pNgu+hqlKf+axtgOXf728J2CGdmZZsgZ2qjRmn03zqs49jLQTmzt6KSYO
	W6lb8A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8h65j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 23:20:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8952346bb9so6158436a12.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784244057; x=1784848857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3hkNEDV7VaPjmHO2+DLTkRD6nf1Orhub6TsamTsGDoQ=;
        b=bIOVUIaShEfoOygNSQbjW+VYpFcw5nPOqSATg2HdrqUidkfZW0bQsfWTYVbCAhW9LS
         Fr/iVcwyLnAg0qdvKYbpyt+0XAPnNSiQwOQrDBV9gbsBMbuIUgDYpbzLF1JDkN48QxXL
         LxM1qOpM58IXYZeR5jGwKXPM0GULNk//JYYSz4v4lX5gtJtIeXP98bw9amD5WxFogl8T
         PbSq2/Q7oQLvF8QhOZqhe54o/BFddmqTsRNbUv3x/4WkL1/mw9MGH5PwE0CKMKXmUSiB
         bOFVUDVbo3N168pBHI8R39Ojj/PY++QoTDOJXxS0/4fREmCSI0jSfaCenAQLGX8i+kxL
         PsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244057; x=1784848857;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hkNEDV7VaPjmHO2+DLTkRD6nf1Orhub6TsamTsGDoQ=;
        b=Y+EbNAftOAoTqxlNoipBruyJoj1R3DiftSxwLS6aBZ+PhKuRHxV+CzXNy4UT15EwwC
         zOO8+SRHWv56Rztrl4EBKoPGqli7B3MHvFu71VbcQNfBYbl4O0d6Cced1600ip5q0dFB
         kKQYE6F5FUXMKHc3JdtLwMHLOepDurK6+lZu7H3339H/A0q2NrlH+Fq5auN2EnhFP3/7
         5peFpWFqWZAuiTBvoXS0E3jLwWy4XCyhZkh3ZgkKWLkEGa6rK+YVbKb6ZvGwB8K/W37W
         xNlKtbh/j1XS4/0tKbV5eaXraPH5t+iPErUSRz285v44SFi7Jze8jqRxzFR3zDawIIMx
         XZig==
X-Gm-Message-State: AOJu0YzeoMVi7Uw1aq1c6O/1I1QiS5x4FZ5Ck3gMRfvzwpkyYzmqGkJ1
	folJj++W1oxqvx5ZOv5MF0+3+ME0sGjDdBj/KB9QyEuN/ATU26e6SVmaMnWTLuVkAvd1rf3Wb0x
	qFi/hGNPlpBqku5jBhkHwPRuGjo0PTuq5zinomYozTppWvWSHHjaJSXQXnZKSiExbmuH4NxE=
X-Gm-Gg: AfdE7cn/pljsCWV8gm6v3/lSO29D2u0H6KCDHYzzUPCYwvTIRa1d7aZzvNO+zqVutR+
	gYKg3YNPkHnVq5DTUd6fha5vKSL0mCSLxIhAONLF+idFfS4Jbyqnu8UdoxdpMnlBGs465MVQl4v
	4aJOpyTJ5SFhuFqbVts7f1NiDJZ6f5WeA/J91wNYeUDH7F8ZstE9AQ0dwFh2AfujnEyLNrgaQQW
	11JXGTtB9VUw/ytg1HFE3G4DpFuLc3b0VtsKiKvnr0+onB/aRZihdXHo5z1G82OTYHXZZuppluY
	2lI1nLzpvFnIXKljH6178BOE/6F+HnMSqUA9aJ9Rnrc7s4NMV5Kt1p+0XtjgJfNH/nvKym2iksz
	3s3ub9ts1WMst01qhHlXMHCd/0A==
X-Received: by 2002:a05:6a21:48f:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3c3ad9691cdmr22487637.46.1784244057220;
        Thu, 16 Jul 2026 16:20:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:48f:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3c3ad9691cdmr22458637.46.1784244056740;
        Thu, 16 Jul 2026 16:20:56 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd428b2d3sm12873962c88.5.2026.07.16.16.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:20:56 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:20:53 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <20260716162053.00006f99@oss.qualcomm.com>
In-Reply-To: <5e9b7479-ed16-48aa-bd4f-26abc09e690e@metafoo.de>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
	<5e9b7479-ed16-48aa-bd4f-26abc09e690e@metafoo.de>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b2h8OamVSMCOFj3rQdCfKLZVZmc5bRdp
X-Proofpoint-ORIG-GUID: b2h8OamVSMCOFj3rQdCfKLZVZmc5bRdp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIzNiBTYWx0ZWRfX/OOyw2ihprDh
 Afvw0YVxpWFMRBQ8cmxihgpKp/jBT8KJPsSGxJu6arpcBO32xT/UQzmZfVM7Rlulat8cr4jvLIn
 mbeWvw/Euu4URSfUVZgzP/gy7v8whNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIzNiBTYWx0ZWRfXx/aE1HLUUwV0
 G/YjbiplLH+nNVilxFj5+u6Ox32aB3/CVS7NqP6xyG2aWBooP+/WISnKI3LGUY3eRkCe7+Ifz3i
 QgcRnPv+khWwqH6uFLYNqPn6kI8CsktVH1yMXeDy1tK2qH/YyCa0Jqj4/xinhWbwUVkqVVMKr9q
 RhLYNoZbSB+oSdHJIn0VISJoNtgTw9hCNSzEgHXcNbWOZe8Y8nF3CgEhTbF2pV86Mhiq9T9WblW
 e7/tx0Nivw2GuG9UkumZ3v1R/n7tnfzvozXrqkEKjstttG6ylnHyNyrFJpzRNzjgX4AUGdVGT75
 zKSPt+OlzGG0RfGbfu52H1NU1VsK76/iAPUz/oEWNYPbVOZiSy9nKA0oIZEmIwiAYbCByWcI550
 GTV3NPrbVAX3q1Rn1TJIf1kK43oi6NVya9jcRWz8tIiOMjka8X7lVdD9OWjj7ZUZqY8HkF7mWyS
 4wBSZLZIhnYJ5lNQonw==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a596759 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=EMjElgS10NdP6WehDt0A:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160236

On Thu, 16 Jul 2026 07:55:32 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 7/15/26 5:57 PM, Jonathan Cameron wrote:
> > Resend to include linux-iio. Sorry to all who get it twice.
> >
> > This came up in a recent review and I realised I have been giving incorrect
> > review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> > the dma safe variants only ever return either an error or the full buffer
> > size.  Short accesses do not occur.  
> There is actually one interesting corner case. If 
> i2c_transfer_buffer_flags() returns 0 i2c_master_{send,recv}() will also 
> return 0, in which case the updated drivers will now read uninitialized 
> memory. Maybe i2c_master_{send,recv}() needs to be updated to translate 
> that to -EIO.

That's indeed curious (and I'd missed it entirely!).

So ends up being either the master_xfer_atomic() or master_xfer() callbacks
returning 0.  master_xfer_atomic() is novel, it's a union with xfer_atomic()
and no one ever sets it via that union element but given the types are the same
all calls will actually be to xfer_atomic().

Could remove that complexity whilst here but there a bunch of related callbacks
(e.g. master_xfer() in union with xfer() where drivers are still using the old
naming and I'm not sure I want to chase that through various subsystem trees
right now (though for fun - and maybe profit) I had claude work out a series.
Was fun watching it write a semantic patch and spend a while debugging it.
Glad it has as much trouble with coccinelle scripts as the rest of us.
There are still a few hundred instances and I haven't touched all the callbacks,
just this pair.

Anyhow, back to the question of whether they do return 0.  Yup they do :(

https://elixir.bootlin.com/linux/v7.1.3/source/drivers/i2c/busses/i2c-cadence.c#L1153

So any defense against that case would require hardening further up the stack.

+CC Andi and the i2c list.  Would anyone mind a patch to do something like:

 static inline int i2c_master_recv(const struct i2c_client *client,
                                  char *buf, int count)
 {
-       return i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
+       int ret;
+
+       ret = i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
+       if (ret == 0)
+               return -EIO;
+
+       return ret;
 };

Just to avoid the need for special case checks on ever call from every driver
so that they return ret if negative or else have to check for non 0 return
value and return -EIO or similar.   Maybe somewhere out there is someone using
that 0 to mean something magic, but I doubt it.

Jonathan

`
> >
> > This series (also my first upstream series prepared by poking claude)
> > removes the redundant checks from all IIO drivers.
> >
> > Thanks,
> >
> > Jonathan
> >
> > Jonathan Cameron (22):
> >    iio: adc: ltc2471: Remove redundant i2c_master_recv() length check
> >    iio: adc: ti-ads7138: Remove redundant i2c_master_send() length checks
> >    iio: adc: versal-sysmon: Remove redundant i2c_master_{send,recv}()
> >      length checks
> >    iio: chemical: scd30: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: chemical: scd4x: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: chemical: sgp30: Remove redundant i2c_master_recv() length check
> >    iio: chemical: sgp40: Remove redundant i2c_master_recv() length check
> >    iio: chemical: sps30: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: dac: ad5446: Remove redundant i2c_master_send() length check
> >    iio: dac: ad5696: Remove redundant i2c_master_send() length check
> >    iio: dac: m62332: Remove redundant i2c_master_send() length check
> >    iio: dac: max517: Remove redundant i2c_master_send() length check
> >    iio: dac: max5821: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: dac: mcp4725: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: dac: mcp4728: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: light: lv0104cs: Remove redundant i2c_master_{send,recv}() length
> >      checks
> >    iio: potentiometer: ad5110: Remove redundant i2c_master_{send,recv}()
> >      length checks
> >    iio: pressure: abp2030pa: Remove redundant i2c_master_{send,recv}()
> >      length checks
> >    iio: pressure: adp810: Remove redundant i2c_master_{send,recv}()
> >      length checks
> >    iio: pressure: icp10100: Remove redundant i2c_master_send() length
> >      check
> >    iio: pressure: mprls0025pa: Remove redundant i2c_master_{send,recv}()
> >      length checks
> >    iio: pressure: sdp500: Remove redundant i2c_master_recv() length check
> >
> >   drivers/iio/adc/ltc2471.c              |  2 --
> >   drivers/iio/adc/ti-ads7138.c           |  4 ----
> >   drivers/iio/adc/versal-sysmon-i2c.c    |  6 ------
> >   drivers/iio/chemical/scd30_i2c.c       |  4 ----
> >   drivers/iio/chemical/scd4x.c           |  8 --------
> >   drivers/iio/chemical/sgp30.c           |  2 --
> >   drivers/iio/chemical/sgp40.c           |  4 ----
> >   drivers/iio/chemical/sps30_i2c.c       |  4 ----
> >   drivers/iio/dac/ad5446-i2c.c           |  2 --
> >   drivers/iio/dac/ad5696-i2c.c           |  2 +-
> >   drivers/iio/dac/m62332.c               |  2 --
> >   drivers/iio/dac/max517.c               |  6 ++----
> >   drivers/iio/dac/max5821.c              | 14 ++------------
> >   drivers/iio/dac/mcp4725.c              | 22 ++++++----------------
> >   drivers/iio/dac/mcp4728.c              | 13 +------------
> >   drivers/iio/light/lv0104cs.c           |  4 ----
> >   drivers/iio/potentiometer/ad5110.c     | 18 +++---------------
> >   drivers/iio/pressure/abp2030pa_i2c.c   |  4 ----
> >   drivers/iio/pressure/adp810.c          |  4 ----
> >   drivers/iio/pressure/icp10100.c        |  2 --
> >   drivers/iio/pressure/mprls0025pa_i2c.c |  4 ----
> >   drivers/iio/pressure/sdp500.c          |  4 ----
> >   22 files changed, 15 insertions(+), 120 deletions(-)
> >  
> 


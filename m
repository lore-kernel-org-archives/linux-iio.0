Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60324 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759301AbaJaOkl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Oct 2014 10:40:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1XkDNO-0007Ku-W1
	for linux-iio@vger.kernel.org; Fri, 31 Oct 2014 15:40:31 +0100
Received: from 37.157.136.206 ([37.157.136.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2014 15:40:30 +0100
Received: from iivanov by 37.157.136.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2014 15:40:30 +0100
To: linux-iio@vger.kernel.org
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v3 2/2] DT: iio: vadc: document dt binding
Date: Fri, 31 Oct 2014 16:40:28 +0200
Message-ID: <54539F5C.50308@mm-sol.com>
References: <1411563415-11933-1-git-send-email-svarbanov@mm-sol.com> <1411563415-11933-3-git-send-email-svarbanov@mm-sol.com> <20141013150039.GB16598@leverpostej> <543CEC7F.50208@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <543CEC7F.50208@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi,

> On 10/13/2014 06:00 PM, Mark Rutland wrote:
>> On Wed, Sep 24, 2014 at 01:56:55PM +0100, Stanimir Varbanov wrote:

>>> +- qcom,ratiometric:
>>> +    Usage: optional
>>> +    Value type: <empty>
>>> +    Definition: Channel calibration type. If this property is specified
>>> +            VADC will use the VDD reference(1.8V) and GND for channel
>>> +            calibration. If property is not found, channel will be
>>> +            calibrated with 625mV and 1.25V reference channels.
>>> +            Otherwise the absolute calibration will be used.
>>
>> Surely this should be part of the specifier?
>

This is per channel type of configuration. Clients didn't and
shouldn't care how calibration is done.

Regards,
Ivan


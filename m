Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342AC433FE
	for <linux-iio@archiver.kernel.org>; Tue, 12 Apr 2022 12:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiDLMyh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355032AbiDLMxr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 08:53:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868B6B53A
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 05:23:26 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kd4Zc587Tz688Km;
        Tue, 12 Apr 2022 20:21:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 14:23:23 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 13:23:23 +0100
Date:   Tue, 12 Apr 2022 13:23:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe De Muyter <phdm@macq.eu>
CC:     <lorenzo.bianconi@st.com>, <lorenzo.bianconi83@gmail.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: st_lsm6dsx : how to accept different chips without error
 message ?
Message-ID: <20220412132322.00000a1a@Huawei.com>
In-Reply-To: <20220412081011.GA32595@frolo.macqel>
References: <20220412081011.GA32595@frolo.macqel>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Apr 2022 10:10:11 +0200
Philippe De Muyter <phdm@macq.eu> wrote:

> Hello Lorenzo,
> 
> we build custom boards with different variations of st_lsm6dsx
> chips, due to the shortage of components, namely the ISM330DHCX
> and ISM330DLC at the moment.  Is there currently a way in the
> driver and device-tree to accept different variations of those
> IMU sensors without getting the annoying message :
> 
> 	st_lsm6dsx_i2c 2-006a: unsupported whoami [6a]
> 
> but rather a positive message telling which variation was found ?

Feel free to send a patch that allows the driver to identify that
it can carry on despite missmatched parts.

We can however 'muddle on' if we have one driver that happens to
support both parts (as is true here). It's made more complex by
the fact this driver covers parts with the same WHOAMI that are
not compatible and for which there is no known safe way to
discover functionality.  So we need to be careful...
My suggestion is we add a field to the _sensor_settings entries for
'minimal parts' to say "if matching without any other info, use
this one if the whoami matches".  For those we pick the least
featured part with a given whoami and hope we don't end up with
an even less featured part in the future.

So on failure to match the whoami normally rerun but looking for
that 'minimal flag' and a whoami match.

Then print out some nice message about the fact that we can only
support minimal functionality because of unknown subvariant with
a given whoami value.

What fun.  Alternatively have your boot loader / firmware adjust the dt
based on what is present ;)

Jonathan


> 
> Best regards
> 
> Phlippe
> 


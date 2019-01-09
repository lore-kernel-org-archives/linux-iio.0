Return-Path: <SRS0=j9az=PR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B46C43387
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jan 2019 06:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7350420821
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jan 2019 06:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSbMMQKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfAIGYc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:24:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60040 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbfAIGYb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2019 01:24:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x096OT1j124752;
        Wed, 9 Jan 2019 06:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TPeASKjh9oCp0Y5wMJ52hLdvI/6zeG9VOZsT/GhFVlU=;
 b=ZSbMMQKqXTwWzAi/Ky1fgFeGdpWtPStbY+eRcJ2TdixfMGHsTnlyChsLWuenGb5AJlqd
 23J6A+S+2ytJUEFzsfeuNyIymQUEKtJXQJv1WqQ7vmMB6/lwmjuf/mwe6HfVy4gQNIhb
 MBQkqVUeTLPm2yMaEjsKapwZePTpQ3j281mAhAhphi50pjcWxBX9r/m9NANUzladhDgW
 egjBJ70++IQf0eIPOT3is5FRwSffHMYJjNf1+UX0TxIV9F9GKByzS1JHq+LFx309KagY
 Nt01Nqs1LEeJUdiqK5YZhFfasRyfrX/BDJgqoKty+GB0+eJOJIngAgJ1CQl2UEdR9gnx +w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ptj3dyr43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 06:24:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x096OLte028481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 06:24:21 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x096OL67028540;
        Wed, 9 Jan 2019 06:24:21 GMT
Received: from kadam (/10.175.191.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 22:24:20 -0800
Date:   Wed, 9 Jan 2019 09:23:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kelly <mkelly@xevo.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [bug report] tools: iio: iio_generic_buffer: allow continuous
 looping
Message-ID: <20190109062350.GI3253@kadam>
References: <20190108203809.GA27223@kadam>
 <45679eeb-c078-0253-4131-1cafaf648050@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45679eeb-c078-0253-4131-1cafaf648050@xevo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=482
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 08, 2019 at 10:20:38PM +0000, Martin Kelly wrote:
> On 1/8/19 12:38 PM, Dan Carpenter wrote:
> > Hello Martin Kelly,
> > 
> > The patch 55dda0abcf9d: "tools: iio: iio_generic_buffer: allow
> > continuous looping" from May 17, 2018, leads to the following static
> > checker warning:
> > 
> > 	./tools/iio/iio_generic_buffer.c:640 main()
> > 	warn: unsigned 'num_loops' is never less than zero.
> > 
> 
> Thanks for catching this. How can I repro this so that I can make sure 
> the static analyzer is happy once I fix it?
> 

It's a Smatch warning.  In this case you would just do:

~/path/to/smatch/smatch tools/iio/iio_generic_buffer.c

regards,
dan carpenter


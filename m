Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2429C10F0E
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7E720833
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wlg+irDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfDIMAN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:00:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfDIMAM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2019 08:00:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39BwWAl178895;
        Tue, 9 Apr 2019 12:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=dWsp8wr1LZdHD+qc3mOxFHahiPMkDmB70nCqCRURoQU=;
 b=Wlg+irDfFRXvmBgx38/YORF8FyQtTlmIzIW80CAmFVSI2hvZPpuVqzsFzW5MlsEwkLk7
 ZRTqbvV04NVG21T/l4VQ5wjqS6B+AZokdVyXhLLT+L6RJtV1c7LflfZ0IISQtHB1Zzf/
 koqjiAR6FaH5gS8FZ1xJ2OuRSxuzqAkQyhnQTt7eoEKTBXZ/xoF6qI7xU60Hnd92V2Cn
 /RKar4BIzK/xkKCVJjbNCDWQ63evs+ralAd947o1JrKgUXdvLfBEy4dVB8EuibqAT0Zi
 Yaeu0gQ8m0lYrwOtxYmVt2Bg8ScJ1T3u1JcpbC0Tqw5ZInPXxaKWJJAWFZUB+Tz+DALr NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrq4cgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 12:00:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39BwSK8033009;
        Tue, 9 Apr 2019 12:00:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rph7shgjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 12:00:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x39C06M9029370;
        Tue, 9 Apr 2019 12:00:07 GMT
Received: from kadam (/197.157.0.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 05:00:06 -0700
Date:   Tue, 9 Apr 2019 14:59:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paresh.chaudhary@rockwellcollins.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio:temperature: Add MAX31856 thermocouple support
Message-ID: <20190409115955.GA16862@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090078
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Paresh Chaudhary,

The patch fb55a51310d1: "iio:temperature: Add MAX31856 thermocouple
support" from Mar 26, 2019, leads to the following static checker
warning:

	drivers/iio/temperature/max31856.c:215 max31856_read_raw()
	error: uninitialized symbol 'ret'.

drivers/iio/temperature/max31856.c
    185 static int max31856_read_raw(struct iio_dev *indio_dev,
    186 			     struct iio_chan_spec const *chan,
    187 			     int *val, int *val2, long mask)
    188 {
    189 	struct max31856_data *data = iio_priv(indio_dev);
    190 	int ret;
    191 
    192 	switch (mask) {
    193 	case IIO_CHAN_INFO_RAW:
    194 		ret = max31856_thermocouple_read(data, chan, val);
    195 		if (ret)
    196 			return ret;
    197 		return IIO_VAL_INT;
    198 	case IIO_CHAN_INFO_SCALE:
    199 		switch (chan->channel2) {
    200 		case IIO_MOD_TEMP_AMBIENT:
    201 			/* Cold junction Temp. Data resolution is 0.015625 */
    202 			*val = 15;
    203 			*val2 = 625000; /* 1000 * 0.015625 */
    204 			ret = IIO_VAL_INT_PLUS_MICRO;
    205 			break;
    206 		default:
    207 			/* Thermocouple Temp. Data resolution is 0.0078125 */
    208 			*val = 7;
    209 			*val2 = 812500; /* 1000 * 0.0078125) */
    210 			return IIO_VAL_INT_PLUS_MICRO;
    211 		}
    212 		break;

Smatch thinks mask can also IIO_CHAN_INFO_PROCESSED, IIO_CHAN_INFO_OFFSET,
and IIO_CHAN_INFO_AVERAGE_RAW.  It often gets these function pointer
calls a be merged together though.

    213 	}
    214 
--> 215 	return ret;
    216 }

regards,
dan carpenter

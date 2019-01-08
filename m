Return-Path: <SRS0=0K8c=PQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF3C43387
	for <linux-iio@archiver.kernel.org>; Tue,  8 Jan 2019 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0B920883
	for <linux-iio@archiver.kernel.org>; Tue,  8 Jan 2019 20:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/Hj3S6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfAHUi1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:38:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49552 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfAHUi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jan 2019 15:38:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x08KYwI1117056;
        Tue, 8 Jan 2019 20:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=pJOQHOMayID1WkEHwaEl8OoJQRELeiNM+sb+FQ+wOng=;
 b=d/Hj3S6xcj5ywsnpobsxZpheI5k67cpHllV+KAX6PJ6Dvg1/5NH/lKIAFHELQLdRX89o
 dUtUmpMuKjdaV5u0NEQhzkhQJf0dmrvniOOvtujJHHj1MpMrLtNxNJWDXw5ByhCTmSFU
 tSzkuYM12UWFxm++CS7U+lX9iH3wf1hoTj5iOjpdttnEhdHpjl/IWskuN/zjsrMsW7du
 33z27Pm3XRrrw1cpCNeOJOTH8vC/XtLG/tZCL2E3vjuZKawIJwbKW2EMPyd6DU6d+YYr
 G2eZifGBW/laoOv6OXpnnA2k4uJ2MW68uaOKDrBh7NvjcfkM2b4geNHcA4SVCpbVUqV2 fw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ptn7qwq89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 20:38:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x08KcOpj005930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 20:38:24 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x08KcNPF007948;
        Tue, 8 Jan 2019 20:38:23 GMT
Received: from kadam (/10.175.191.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 12:38:23 -0800
Date:   Tue, 8 Jan 2019 23:38:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mkelly@xevo.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] tools: iio: iio_generic_buffer: allow continuous looping
Message-ID: <20190108203809.GA27223@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080159
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Martin Kelly,

The patch 55dda0abcf9d: "tools: iio: iio_generic_buffer: allow
continuous looping" from May 17, 2018, leads to the following static
checker warning:

	./tools/iio/iio_generic_buffer.c:640 main()
	warn: unsigned 'num_loops' is never less than zero.

./tools/iio/iio_generic_buffer.c
    331 int main(int argc, char **argv)
    332 {
    333 	unsigned long long num_loops = 2;
                ^^^^^^^^

    334 	unsigned long timedelay = 1000000;
    335 	unsigned long buf_len = 128;
    336 
    337 	ssize_t i;
    338 	unsigned long long j;
    339 	unsigned long toread;
    340 	int ret, c;
    341 	int fp = -1;
    342 
    343 	int num_channels = 0;
    344 	char *trigger_name = NULL, *device_name = NULL;
    345 
    346 	char *data = NULL;
    347 	ssize_t read_size;
    348 	int dev_num = -1, trig_num = -1;
    349 	char *buffer_access = NULL;
    350 	int scan_size;
    351 	int noevents = 0;
    352 	int notrigger = 0;
    353 	char *dummy;
    354 	bool force_autochannels = false;
    355 
    356 	struct iio_channel_info *channels = NULL;
    357 

[ snip ]

    632 	/* Attempt to open non blocking the access dev */
    633 	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
    634 	if (fp == -1) { /* TODO: If it isn't there make the node */
    635 		ret = -errno;
    636 		fprintf(stderr, "Failed to open %s\n", buffer_access);
    637 		goto error;
    638 	}
    639 
--> 640 	for (j = 0; j < num_loops || num_loops < 0; j++) {
                                             ^^^^^^^^^^^^^
If num_loops is -1 then it's supposed to loop forever.  It basically
does, except for the static checker warning.

    641 		if (!noevents) {
    642 			struct pollfd pfd = {
    643 				.fd = fp,
    644 				.events = POLLIN,
    645 			};
    646 
    647 			ret = poll(&pfd, 1, -1);
    648 			if (ret < 0) {
    649 				ret = -errno;
    650 				goto error;
    651 			} else if (ret == 0) {
    652 				continue;
    653 			}
    654 
    655 			toread = buf_len;
    656 		} else {
    657 			usleep(timedelay);
    658 			toread = 64;
    659 		}

regards,
dan carpenter

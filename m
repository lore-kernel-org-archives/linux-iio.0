Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE361CCA47E
	for <linux-iio@archiver.kernel.org>; Thu,  2 Jun 2022 20:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiFBUCu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiFBUCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2022 16:02:43 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 13:02:32 PDT
Received: from smtp687out9.mel.oss-core.net (smtp687out9.mel.oss-core.net [210.50.216.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A43E410A3
        for <linux-iio@vger.kernel.org>; Thu,  2 Jun 2022 13:02:31 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AWbgDRFZli/7NplnpaGQEBAQEBASsLBgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQIBAQEBAQEBAQEBARUJgUYCgToCAQEBpD6HGRuCJYdngXwLAQEBITAEA?=
 =?us-ascii?q?QGEeAEBhVEmNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEGBIEchS9Gh?=
 =?us-ascii?q?lQgBwGBVgEOAR6FdQEBrG6BMw10hFkUghAECoJzgTsCAQEBAQGJQoVffYEQh?=
 =?us-ascii?q?BABhX2DQIIuBJJGhCMEGzsDIRUYNBKBIUUsAQgGBgcKBTIGAgwYFAQCExJTH?=
 =?us-ascii?q?QISDAocDlQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAy4CAxgJBwoDHQgKChISE?=
 =?us-ascii?q?BQCBAYNHgsIAxkfLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGA?=
 =?us-ascii?q?wYCBQUBAyADFAMFJwcDIQcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICcQooD?=
 =?us-ascii?q?QgECAQMEB0lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2G?=
 =?us-ascii?q?QEFDk8GCwkhHAkgEQUGFgMjcwVIDyk1OQZ8D65SkECeMwqDTgUpB4EJB55JM?=
 =?us-ascii?q?YNjAZcSEQEngVeLVJZoqBKBCQOCC3AVggiBHFAonRCBEAIGCwEBAwmPCgEB?=
IronPort-Data: A9a23:SUGX2aJtIdUGzez8FE+RWJclxSXFcZb7ZxGr2PjKsXjdYENS02cCy
 jYWDWiDPvveMTP1KN0naIyy9hlVv5WByN9iSwMd+CA2RRqmi+KbXIjFdi8cHM8zwunrFh8PA
 xA2M4GYRCwMo/u1Si6FatANl1ElvU2zbue6Wbes1hxZH1c+En9/0Ug7wYbVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQ33P0JGMITN3tIlirQgelh8
 8xIqMavHFJB0q3kwIzxUjFnMgc7H/Jp1pPtCF/i6O77I0/uKiG2hawzVAdvZdBeo7kmaY1N3
 aVwxDQlbxaNgMqzybS3W69ngcFLwMzDbNlH5y8/kWux4fAOXKLME53n4PZhjTIinfBeGNXOO
 PMzQG86BPjHS1gVUrsNM7o6neG1ljz+cjpwtl2Yv+w07nLVwQg316LiWOc5YfTTH58QxxvA4
 zueoiGgXUBcL8CWjyWP6HWliuXGmy+9Xo8OUrSlnhJ3vGCuKqUoIEV+fTOGTTOR0yZSh/o3x
 5QoxxcT
IronPort-HdrOrdr: A9a23:z1f+eaxnYEzXjoIm+kWTKrPwT71zdoMgy1knxilNoHtuHfBw9v
 rDoB11737JYVoqM03I5+rhBEDoexq1yXcS2+cs1NyZNjUO1lHEEL1f
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,272,1647262800"; 
   d="scan'208";a="82056742"
Received: from 122-150-105-179.sta.wbroadband.net.au (HELO WIN-J7GFDBAO51J) ([122.150.105.179])
  by smtp687.mel.oss-core.net with ESMTP; 03 Jun 2022 06:01:26 +1000
From:   "Martin Otamori" <info@mandy.com>
Subject: Acknowledge this message
To:     <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <okkmart68@gmail.com>
Date:   Thu, 2 Jun 2022 13:01:23 -0700
Message-Id: <0222202206011345801388D5$FE67EACE18@mandy.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I will give you more details as soon as you acknowledge this message.
Thank you.
Martin Otamori.


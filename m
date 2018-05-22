Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:54127
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751566AbeEVOSC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 10:18:02 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v2 0/5] iio: imu: inv_mpu6050: add new timestamping mechanism
Date: Tue, 22 May 2018 14:17:59 +0000
Message-ID: <CY4PR1201MB0184523D958FBF30BF83C48BC4940@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The purpose of this series is to implement a new timestamping mechanism=20
able to cope with missing and delayed interrupts.

Changelog:
* v2
        - use macros for handling chip internal divider, fifo rate, and fre=
quency divider
        - use better names for functions and variable dealing with timestam=
p estimation

Thanks.
JB=

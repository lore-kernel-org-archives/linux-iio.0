Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D23C636CC
	for <linux-iio@archiver.kernel.org>; Sun,  5 Feb 2023 10:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjBEKM3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Feb 2023 05:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBEKM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 05:12:29 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 240931DBBA
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 02:12:26 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id B5A36DF00BC; Sun,  5 Feb 2023 11:12:23 +0100 (CET)
Date:   Sun, 5 Feb 2023 11:12:23 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Subject: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <20230205101223.GA10729@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo and list,

I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.

Every time I start a new acquisition of gyro values, the first two
values read are wrong, as can be see here :

 $ sudo ./iio_generic_buffer -n ism330dlc_gyro -g -c 10 -a
 iio device number being used is 1
 trigger-less mode selected
 No channels are enabled, enabling all channels
 Enabling: in_anglvel_z_en
 Enabling: in_timestamp_en
 Enabling: in_anglvel_y_en
 Enabling: in_anglvel_x_en
 -0.138924 -0.915246 0.470628 1675591514696125669
 -0.012699 -0.362151 0.143208 1675591514772675669
 0.001989 -0.076500 0.035190 1675591514849250669
 0.002295 -0.076194 0.035343 1675591514925825669
 0.002142 -0.076041 0.035343 1675591515002400669
 0.001989 -0.076041 0.035343 1675591515078975669
 0.001836 -0.076347 0.035649 1675591515155525669
 0.001836 -0.076500 0.035649 1675591515232075669
 0.001989 -0.076500 0.035649 1675591515308625669
 0.001989 -0.076347 0.035649 1675591515385200669
 Disabling: in_anglvel_z_en
 Disabling: in_timestamp_en
 Disabling: in_anglvel_y_en
 Disabling: in_anglvel_x_en
 $

Is that a normal behaviour for a gyro in that family or is it be caused
by a software or hardware bug ?

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

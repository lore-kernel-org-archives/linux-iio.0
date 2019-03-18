Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ABAC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73BA20854
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCRP5O (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:57:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:16084 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCRP5O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Mar 2019 11:57:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 08:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="p7s'?scan'208";a="329680760"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 08:57:12 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 18 Mar 2019 08:57:11 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.11]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.82]) with mapi id 14.03.0415.000;
 Mon, 18 Mar 2019 08:57:11 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>
Subject: Re: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Thread-Topic: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Thread-Index: AQHU3CbSy/88SJFrT0i65NWQX4BOOaYQfPeAgACGHgCAAJT9gIAAa3MA
Date:   Mon, 18 Mar 2019 15:57:10 +0000
Message-ID: <5a5759a9217baf5eb1fe0c63414260f0d599e81c.camel@intel.com>
References: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
         <20190316183348.76573887@archlinux>
         <b6795bcb3d1c6e827c256e9c16f6e582b29358fc.camel@intel.com>
         <7552a684-90ea-2066-ef0b-4e25390b6d55@ozlabs.ru>
         <d5773e94-043a-2971-2c2e-2838b9105df2@ozlabs.ru>
In-Reply-To: <d5773e94-043a-2971-2c2e-2838b9105df2@ozlabs.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-gjlsO+vLZcOPNG8sDWXC"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-gjlsO+vLZcOPNG8sDWXC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-03-18 at 20:32 +1100, Alexey Kardashevskiy wrote:
>=20
> On 18/03/2019 11:39, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 18/03/2019 03:39, Pandruvada, Srinivas wrote:
> > > On Sat, 2019-03-16 at 18:33 +0000, Jonathan Cameron wrote:
> > > > +CC bastien and (guessing it is a HID sensor) Srinivas.
> > > > On Sat, 16 Mar 2019 20:16:39 +1100
> > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > >=20
> > > > > Hi!
> > > > >=20
> > > > > I got a quite old Lenovo YOGA 700-11ISK with flip screen and
> > > > > run
> > > > > fedora29 on it. I found that gnome3 cannot properly detect
> > > > > the
> > > > > screen
> > > > > orientation and the screen keeps rotating non stop.
> > > > >=20
> > > > > I opened an issue agains iio-sensor-proxy, not much luck
> > > > > there.
> > > > > https://github.com/hadess/iio-sensor-proxy/issues/220
> > > > >=20
> > > > > I resumed my debugging and the situation seems improving.
> > > > >=20
> > > > > The yoga is running fedora29 v4.20.14. The fedora's iio-
> > > > > sensor-
> > > > > proxy
> > > > > still has this problem and so does the iio-sensor-proxy
> > > > > upstream
> > > > > version.
> > > > >=20
> > > > > Then I commented out &iio_buffer_accel to make
> > > > > &iio_poll_accel work
> > > > > -
> > > > > and things worked nicely. I looked in sysfs and
> > > > > in_accel_?_raw seem
> > > > > to
> > > > > have correct values (same as in the first log below, give or
> > > > > take),
> > > > > all
> > > > > good. Recorded some debug from iio-sensor-proxy:
> > > > >=20
> > > > > Accel read from IIO on 'accel_3d': -39, -937, -378 (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): -39, -937, -378 (scale:
> > > > > 0.009807)
> > > > > Emitted orientation changed: from undefined to normal
> > > > > No new data available on 'iio:device3'
> > > > > Accel read from IIO on 'accel_3d': -39, -933, -371 (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): -39, -933, -371 (scale:
> > > > > 0.009807)
> > > > > No new data available on 'iio:device3'
> > > > > Accel read from IIO on 'accel_3d': -39, -933, -367 (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): -39, -933, -367 (scale:
> > > > > 0.009807)
> > > > >=20
> > > > > This is the good log, gnome works fine.
> > > > >=20
> > > > >=20
> > > > > Then I recorded debug with the buffer driver enabled:
> > > > >=20
> > > > > rocess_scan_1: channel_index: 0, chan_name: in_accel_x,
> > > > > channel_data_index: 0 location: 0
> > > > > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > > > > channel_data_index: 1 location: 4
> > > > > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > > > > channel_data_index: 2 location: 8
> > > > > Accel read from IIO on 'iio:device4': -15, -898, -375 (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): -15, -898, -375 (scale:
> > > > > 0.009807)
> > > > > Emitted orientation changed: from undefined to normal
> > > > > No new data available on 'iio:device3'
> > > > > process_scan_1: channel_index: 0, chan_name: in_accel_x,
> > > > > channel_data_index: 0 location: 0
> > > > > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > > > > channel_data_index: 1 location: 4
> > > > > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > > > > channel_data_index: 2 location: 8
> > > > > Accel read from IIO on 'iio:device4': 20774, 27203, 0 (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): 20774, 27203, 0 (scale:
> > > > > 0.009807)
> > > > > Emitted orientation changed: from normal to left-up
> > > > > No new data available on 'iio:device3'
> > > > > process_scan_1: channel_index: 0, chan_name: in_accel_x,
> > > > > channel_data_index: 0 location: 0
> > > > > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > > > > channel_data_index: 1 location: 4
> > > > > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > > > > channel_data_index: 2 location: 8
> > > > > Accel read from IIO on 'iio:device4': -31, -929, -398 (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): -31, -929, -398 (scale:
> > > > > 0.009807)
> > > > > Emitted orientation changed: from left-up to normal
> > > > > No new data available on 'iio:device3'
> > > > > process_scan_1: channel_index: 0, chan_name: in_accel_x,
> > > > > channel_data_index: 0 location: 0
> > > > > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > > > > channel_data_index: 1 location: 4
> > > > > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > > > > channel_data_index: 2 location: 8
> > > > > Accel read from IIO on 'iio:device4': -14345, -32024, 12738
> > > > > (scale
> > > > > 0.009807)
> > > > > Accel sent by driver (quirk applied): -14345, -32024, 12738
> > > > > (scale:
> > > > > 0.009807)
> > > > >=20
> > > > > So it is good reading, bad reading, good reading, bad
> > > > > reading, and
> > > > > gnome
> > > > > rotates the screen non stop. No wonder gnome3 goes crazy.
> > >=20
> > > I suppose you don't move the screen.
> >=20
> > Correct.
> >=20
> > > Try this to see if there is some
> > > conversion errors in iio-sensor-proxy in some cases. Raw data is
> > > a
> > > simply push from firmware, without any conversion..
> >=20
> > Where does this push happen? Here?
> >=20
> >=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/iio/accel/hid-sensor-accel-3d.c#n244
> >=20
> >=20
> > > rename /usr/sbin/iio-sensor-proxy for test only. Then reboot.
> > > As part of linux kernel git, tools/iio, build iio-generic-buffer.
> > >=20
> > > #sudo ./iio_generic_buffer -l 1 -a -c 100 -n accel_3d'
> >=20
> >=20
> > I'll give it a try tonight.
>=20
>=20
> Tried. The laptop was on a desk, firmly fixed, the tool printed first
> 2
> entries and stops, I had to tap slightly on the laptop to make it
> continue. Tried a few times, first few readings, a pause, a tap,
> continues. In the example below one reading is weird (usually more
> are
> weird), others seem good.
That is the correct behavior. Unless the data changes by some
threshold, it shouldn't send more samples.

>=20
> [root@aikyoga aik]# ./iio_generic_buffer -l 1 -a -c 100 -n accel_3d
> iio device number being used is 0
> iio trigger number being used is 0
> Enabling all channels
> Enabling: in_accel_x_en
> Enabling: in_accel_z_en
> Enabling: in_timestamp_en
> Enabling: in_accel_y_en
> /sys/bus/iio/devices/iio:device0 accel_3d-dev0
> -0.382459 -9.071151 -3.824593 1552900771368191813
> -0.382459 -9.071151 -3.824593 1552900771376264500
> -0.343233 -8.423912 -4.971972 1552900776231212060
> 0.000000 0.000000 0.000000 1552900776232597107
We are getting false interrupts, with invalid data (0s here).
We can try ignoring samples in iio-sensor-proxy when all axes are 0s to
workaround and try. In kernel drivers, we don't look at the data
received in buffer mode.

The iio-sensor-proxy code in github, so if you want to give a try.

Thanks,
Srinivas=20

> -0.343233 -8.384686 -4.971972 1552900776251252367
> 0.000000 0.000000 0.000000 1552900776252606419
> -0.343233 -8.345459 -5.011198 1552900776271057304
> 0.000000 0.000000 0.000000 1552900776272409930
> -0.264780 -8.306232 -5.089651 1552900776291133439
> 0.000000 0.000000 0.000000 1552900776292461896
> -0.225553 -8.306232 -5.168105 1552900776311581316
> 225.484299 -153.042572 20.466478 1552900776312958364
> -0.225553 -8.306232 -5.168105 1552900776331232430
> 0.000000 0.000000 0.000000 1552900776332459423
> -0.225553 -8.267006 -5.128878 1552900776351265820
> 0.000000 0.000000 0.000000 1552900776352593055
> -0.264780 -8.267006 -5.168105 1552900776371443772
> 0.000000 0.000000 0.000000 1552900776372784463
> -0.264780 -8.267006 -5.246558 1552900776391549343
> 0.000000 0.000000 0.000000 1552900776392968369
> -0.225553 -8.306232 -5.315204 1552900776411677753
> 0.000000 0.000000 0.000000 1552900776412998853
> -0.225553 -8.306232 -5.285784 1552900776431528699
> 0.000000 0.000000 0.000000 1552900776432881821
> -0.225553 -8.306232 -5.207331 1552900776451678405
> 0.000000 0.000000 0.000000 1552900776452999756
> -0.264780 -8.306232 -5.168105 1552900776471988891
> 0.000000 0.000000 0.000000 1552900776473335616
> -0.264780 -8.306232 -5.168105 1552900776491891346
> 0.000000 0.000000 0.000000 1552900776493215237
> -0.264780 -8.306232 -5.207331 1552900776516048625
> 0.000000 0.000000 0.000000 1552900776517478859
> -0.264780 -8.306232 -5.207331 1552900776535855901
> 0.000000 0.000000 0.000000 1552900776537239117
> -0.264780 -8.306232 -5.207331 1552900776556004660
> 0.000000 0.000000 0.000000 1552900776557361617
> -0.264780 -8.306232 -5.168105 1552900776575969969
> 0.000000 0.000000 0.000000 1552900776577367957
> -0.264780 -8.306232 -5.168105 1552900776596219505
> 0.000000 0.000000 0.000000 1552900776597645139
> -0.304006 -8.306232 -5.168105 1552900776616188646
> 0.000000 0.000000 0.000000 1552900776617519289
> -0.304006 -8.306232 -5.168105 1552900776636243776
> 0.000000 0.000000 0.000000 1552900776637629204
> -0.264780 -8.306232 -5.207331 1552900776656315247
> 0.000000 0.000000 0.000000 1552900776657662508
> -0.264780 -8.306232 -5.246558 1552900776676430435
> 0.000000 0.000000 0.000000 1552900776677854697
> -0.225553 -8.306232 -5.246558 1552900776696561899
> 0.000000 0.000000 0.000000 1552900776697953993
> -0.225553 -8.306232 -5.246558 1552900776716687038
> 0.000000 0.000000 0.000000 1552900776718013507
> -0.225553 -8.306232 -5.207331 1552900776736600192
> 0.000000 0.000000 0.000000 1552900776737979245
> -0.264780 -8.306232 -5.207331 1552900776756661393
> 0.000000 0.000000 0.000000 1552900776757973656
> -0.264780 -8.345459 -5.168105 1552900776776918044
> 0.000000 0.000000 0.000000 1552900776778285204
> -0.304006 -8.345459 -5.168105 1552900776796719607
> 0.000000 0.000000 0.000000 1552900776798043915
> -0.304006 -8.345459 -5.168105 1552900776816969788
> 0.000000 0.000000 0.000000 1552900776818346899
> -0.304006 -8.345459 -5.168105 1552900776836866458
> 0.000000 0.000000 0.000000 1552900776838190275
> -0.264780 -8.306232 -5.207331 1552900776857025283
> 0.000000 0.000000 0.000000 1552900776858365006
> -0.225553 -8.306232 -5.246558 1552900776876999835
> 0.000000 0.000000 0.000000 1552900776878320702
> -0.225553 -8.306232 -5.246558 1552900776897067887
> 0.000000 0.000000 0.000000 1552900776898409864
> -0.264780 -8.306232 -5.246558 1552900776917154306
> 0.000000 0.000000 0.000000 1552900776918528686
> -0.264780 -8.306232 -5.207331 1552900776937174085
> 0.000000 0.000000 0.000000 1552900776938501132
> -0.264780 -8.345459 -5.168105 1552900776957203402
> 0.000000 0.000000 0.000000 1552900776958540063
> -0.264780 -8.345459 -5.168105 1552900776977338314
> 0.000000 0.000000 0.000000 1552900776978682085
> -0.264780 -8.345459 -5.168105 1552900776997480789
> 0.000000 0.000000 0.000000 1552900776998808922
> -0.264780 -8.306232 -5.168105 1552900777017397456
> 0.000000 0.000000 0.000000 1552900777018741222
> -0.264780 -8.306232 -5.207331 1552900777037476271
> 0.000000 0.000000 0.000000 1552900777038806156
> -0.264780 -8.306232 -5.207331 1552900777057563044
> 0.000000 0.000000 0.000000 1552900777058959603
> -0.264780 -8.306232 -5.207331 1552900777077670982
> 0.000000 0.000000 0.000000 1552900777078985450
> -0.264780 -8.306232 -5.207331 1552900777097699720
> 0.000000 0.000000 0.000000 1552900777099120245
> -0.264780 -8.306232 -5.168105 1552900777117694705
> 0.000000 0.000000 0.000000 1552900777119056044
> -0.264780 -8.306232 -5.168105 1552900777137793443
> 0.000000 0.000000 0.000000 1552900777139114214
> -0.264780 -8.306232 -5.168105 1552900777158067260
> 0.000000 0.000000 0.000000 1552900777159426560
> -0.264780 -8.306232 -5.207331 1552900777177946936
> 0.000000 0.000000 0.000000 1552900777179274696
> -0.264780 -8.306232 -5.207331 1552900777198216778
> 0.000000 0.000000 0.000000 1552900777199587760
> Disabling: in_accel_x_en
> Disabling: in_accel_z_en
> Disabling: in_timestamp_en
> Disabling: in_accel_y_en
> [root@aikyoga aik]#
>=20
>=20
> But then I did more experimenting. I put laptop on my laps (so it was
> not firmly fixed but I did not move it or rotate it) and started the
> tool again. I got quite inconsistent readings:
>=20
> -0.186326 -8.463139 -4.971972 1552900984763903094
> -141.853195 -235.241913 251.001205 1552900984765201219
> -0.186326 -8.423912 -4.824872 1552900984783855026
> 172.204773 249.824402 -219.482635 1552900984785172204
> -0.147100 -8.423912 -4.628739 1552900984803895624
> -219.482635 186.777451 -235.241913 1552900984805211796
> -0.029420 -8.463139 -4.403186 1552900984823989997
> 0.000000 -32.705177 -235.241913 1552900984825302896
> 0.107873 -8.502365 -4.285506 1552900984843951448
> 0.000000 -32.705177 -235.241913 1552900984845283264
> 0.186326 -8.541592 -4.442412 1552900984864076546
> 251.001205 -173.381561 187.964050 1552900984865409126
>=20
>=20
> And then I run it as "./iio_generic_buffer -l 1 -a -c 10000 -n
> accel_3d"
> (10000 vs 100) and I got 10000 of very consistent readings like this:
>=20
> -0.068647 -8.463139 -4.785645 1552900954123256005
> -0.068647 -8.463139 -4.785645 1552900954124609317
> 0.000000 -8.502365 -5.050425 1552900954223793352
> 0.000000 -8.502365 -5.050425 1552900954225123224
> 0.107873 -8.463139 -4.824872 1552900954504475745
> 0.107873 -8.463139 -4.824872 1552900954505898733
> -0.147100 -8.463139 -4.824872 1552900954564807056
>=20
>=20
> I tried bisecting the number but around 3900..4000 it simply gave up
> :)
>=20
> [  539.215108] i2c_designware i2c_designware.0: controller timed out
> [  539.240414] i2c_designware i2c_designware.0: timeout in disabling
> adapter
> [  539.263406] i2c_designware i2c_designware.0: timeout waiting for
> bus
> ready
> [  539.263410] i2c_hid i2c-ITE8350:00: failed to set a report to
> device.
> [  539.285978] i2c_designware i2c_designware.0: timeout waiting for
> bus
> ready
>=20
>=20
> Looks like a weird accident though.
>=20
>=20
> >=20
> >=20
> > >=20
> > >=20
> > > Thanks,
> > > Srinivas
> > >=20
> > > > >=20
> > > > > I would debug further and even come up with a fix but I
> > > > > failed to
> > > > > find
> > > > > quickly where there reads are handled in the kernel, and what
> > > > > defines
> > > > > these in_accel_?_raw files in sysfs, tried grepping -
> > > > > nothing. Any
> > > > > pointers?
> > >=20
> > >=20
> > > >=20
> > > > The raw files are built by the IIO core to call the read_raw
> > > > callback
> > > > in the
> > > > each driver.  The path for buffered data is very different.
> > > > Ultimately
> > > > it goes through a call to iio_push_to_buffers.
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Also, how do I identify my particular 3d sensor? Or it is the
> > > > > same
> > > > > model
> > > > > everywhere? Or it is the driver for all of them?
> > > >=20
> > > > Lots an lots and lots of drivers ;)   But in laptops they are
> > > > often
> > > > hid-sensors, or at least there is a little microcontroller that
> > > > handles
> > > > the different streams and reformats them as hid sensor records.
> > > >=20
> > > > >=20
> > > > > Here is dmesg | grep i2c:
> > > >=20
> > > > First of all, let us check the device. I'm going to guess it's
> > > > a hid
> > > > sensor of some type.
> > > > Could you cat
> > > > /sys/bus/iio/devices/iio\:device0/name
> > > >=20
> > > > When iio-sensor-proxy is running (or after you've killed it)
> > > > check
> > > > what the values in the various files in
> > > > /sys/bus/iio/devices/iio\:device0/scan_elements/*=20
> > > > are.  One thought is we have some unexpected channels enabled
> > > > and
> > > > the code is thinking they are acceleration when they aren't.
> > > >=20
> > > > >=20
> > > > > [root@aikyoga iio:device4]# dmesg | egrep '(i2c|iio)'
> > > > > [    5.389867] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply
> > > > > vdd
> > > > > not
> > > > > found, using dummy regulator
> > > > > [    5.389893] i2c_hid i2c-ITE8350:00: Linked as a consumer
> > > > > to
> > > > > regulator.0
> > > > > [    5.389896] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply
> > > > > vddl
> > > > > not
> > > > > found, using dummy regulator
> > > > > [    5.502896] hid-generic 0018:048D:8350.0002: hidraw1: I2C
> > > > > HID
> > > > > v1.00
> > > > > Device [ITE8350:00 048D:8350] on i2c-ITE8350:00
> > > > > [    5.528455] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00
> > > > > supply vdd
> > > > > not
> > > > > found, using dummy regulator
> > > > > [    5.528485] i2c_hid i2c-SYNA2B23:00: Linked as a consumer
> > > > > to
> > > > > regulator.0
> > > > > [    5.528489] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00
> > > > > supply vddl
> > > > > not
> > > > > found, using dummy regulator
> > > > > [    5.543440] input: SYNA2B23:00 06CB:2714 Mouse as
> > > > > /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-
> > > > > SYNA2B23:00/0018:06CB:2714.0003/input/input13
> > > > > [    5.543690] hid-generic 0018:06CB:2714.0003:
> > > > > input,hidraw2: I2C
> > > > > HID
> > > > > v1.00 Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
> > > > > [    6.053237] input: Synaptics TM2714-002 as
> > > > > /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-
> > > > > SYNA2B23:00/0018:06CB:2714.0003/input/input16
> > > > > [    6.053444] hid-rmi 0018:06CB:2714.0003: input,hidraw1:
> > > > > I2C HID
> > > > > v1.00
> > > > > Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
> > > > >=20
> > > > > Thanks!
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
>=20
>=20

--=-gjlsO+vLZcOPNG8sDWXC
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
zFtUc0whb39jT7klbqWD26anBZ8LZsRmaU2FylSgaQm5IMl6ILV2cDVhBitGeKIwNYMqpcLejOnr
Zbrn3/QvAgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUBdulS2EQ0eFtMXDEFoVPVLcb8dwwHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQC3BC7joH3dX6x9O8HsMgJ8DgZp
OnY6eG3DVzJSonWr++Pv4CRQ6wh+J7bH3hTBq+tb2xbe2ZAfudqX/gezisOufHOKm0gs1UGBxFdj
snEt87sD096N34r2lE1tUDyPARQNKangT4IFJ273PSYg2zlbbJYoWeOq76SS3SfcH58FsAO5d70d
cCAW38N1mc+LWHBnEEN3dfFrNQgZSiqZ8jenu/a3FhqbhIMZbwa/Zlnuz8LPUIrjiEblAhmab3m4
B+Dg1xocVmrPOrLbjxwULJldJEDvhwXzEeFCdTPp2/0O28Jmi0Upxb3QBfhczCcZ95/H6X6gQdfW
89/DPXl9Dl4IMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMcBCehwTtyBUDoAAAAAxwEwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMx
ODE1NTcwOFowIwYJKoZIhvcNAQkEMRYEFHnCkWVjAg00tLX6qfJLqA8voIkVMA0GCSqGSIb3DQEB
AQUABIIBABA9d4JZo4XQDAqNq9Hht3yga2CgaQkkFu7W4YNM0wCkswwrCI1bgwpbKsNFZf/2o2FN
6VE52IXNR/famxNBLnYdFbObTXzWWtTF3oCMu0UErgBve/G/Pmd670U4pBxlIJpWUE38qSHk2Ouz
fxy2V03K2X9NyNV2Qs0HCRne+sMRttRls0JVFtj1xSVifN33nFRI1vS9qZ1/DvgvPBn/6tHYz/2K
vpuilotX35SfNPVd2frrVoYlylczve8n1efqCUFzQXOZ44Pxt9e3BP7Zmz3/QsoUHbhf4n0h7atF
6jy17NRBXzaljKjVJp14lzkJOtImLF59ctnwIzTQecLjiVwAAAAAAAA=


--=-gjlsO+vLZcOPNG8sDWXC--

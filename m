Return-Path: <chrismicali@gmail.com>
Date: Mon, 4 Mar 2013 15:37:22 -0500
From: Chris Micali <chrismicali@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "=?utf-8?Q?linux-iio=40vger.kernel.org?=" <linux-iio@vger.kernel.org>
Message-ID: <EF0F19ECEFC64241BFFA64293C190541@gmail.com>
In-Reply-To: <51322863.4070901@kernel.org>
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com>
 <512E2F31.8000604@metafoo.de>
 <B42F83EDFE8B4D2D8D46B6241B49B4E8@gmail.com>
 <512E3592.4020702@metafoo.de>
 <4AEA8015FE824807B3CF62B7B35FC5D3@gmail.com>
 <512E43A9.4090301@metafoo.de>
 <5277B88AB1FF4E6A83920766C0BE13F7@gmail.com>
 <512E5054.8030905@kernel.org> <512E55AA.6050203@metafoo.de>
 <5CCB32D4B146494F902390C27F8216A8@gmail.com>
 <51322863.4070901@kernel.org>
Subject: Re: IIO Drivers
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="51350602_8edbdab_c85"
List-ID: <linux-iio@vger.kernel.org>

--51350602_8edbdab_c85
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jonathan, =20

Thanks - I'll share back my findings this week.

One thing i've run into is throughput - it seems like the linux spi subsy=
stem has a non-deterministic 50-150us delay before an spi=5Fsync or spi=5F=
async command is processed.  I can't seem to find any way around this - s=
o if i use larger multi-byte transfers using spi=5Fasync and DMA I get gr=
eat, stable throughput, but that is broken up by these 50-150us delays be=
tween transfers (i'm using the beagle bone, so AM3359 that has a dedicate=
d SPI controller and DMA.)  =20

Have any of you guys had success getting reliable >1MSPS throughput via I=
IO over SPI=3F  It seems like this inherent delay in the SPI subsystem wo=
uld make this pretty difficult.

-chris


On Saturday, March 2, 2013 at 11:27 AM, Jonathan Cameron wrote:

> On 02/27/2013 07:32 PM, Chris Micali wrote:
> > Guys, =20
> > =20
> > Thanks a lot for the help=21 I finally tracked down issues, it was a =
combination of a few things:
> > =20
> > 1. The .channel had to be 0, not 1 in the driver (scan=5Findex didn't=
 matter)
> > 2. 1 or more scan=5Felements have to be enabled as you mentioned
> > 2. When echoing into the sysfs files it has to have a space after the=
 number (cat 1 > in=5Fvoltage0=5Fen and not cat 1>in=5Fvo=E2=80=A6) (duh=21=
)
> > 3. The generic=5Fbuffer.c program had a few bugs in it causing crashe=
s. I updated the iio=5Futils.h to a newer version I found here: https://g=
ithub.com/analogdevicesinc/iio-oscilloscope and then made a few modificat=
ions (the newer iio=5Futils did not parse a few things right in the chann=
el details like bigendian/littleendian)
> > =20
> > So generic=5Fbuffer is now correctly sampling (although it crashes af=
ter a couple, it's probably another iio=5Futils issue)
> If you do track down why this is happening, please do report back
> so we can get it fixed. I wasn't previously aware of any particular
> issues in the example code so any feedback is helpful=21
> =20
> Looking foward to seeing the driver code when you are happy with it.
> =20
> Jonathan
> > Thanks=21=21
> > =20
> > -chris
> > =20
> > =20
> > On Wednesday, =46ebruary 27, 2013 at 1:51 PM, Lars-Peter Clausen wrot=
e:
> > =20
> > > On 02/27/2013 07:28 PM, Jonathan Cameron wrote:
> > > > On 02/27/2013 05:36 PM, Chris Micali wrote:
> > > > > lars, =20
> > > > > =20
> > > > > I was under the impression that flag gets added automatically b=
y iio=5Ftriggered=5Fbuffer=5Fsetup (industrialiio-triggers.c:77) - I actu=
ally am now able to enable the scan=5Felement after changing my channel .=
channel and .scan=5Findex to 0 (trying to match exactly the other drivers=
.)
> > > > > =20
> > > > =20
> > > > =20
> > > =20
> > > =20
> > > Yea, you are right I missed the iio=5Ftriggered=5Fbuffer=5Fsetup pa=
rt.
> > > =20
> > > > Strange, scan=5Findex should have defaulted to zero and the .chan=
nel value shouldn't have mattered
> > > > for buffered reads (just effects naming). Might have caused issue=
s with userspace expecting a channel 0
> > > > though...
> > > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > I guess the scan=5Findex had nothing to do with this, but I suggest=
ed to set
> > > scan=5Felements/in=5Fvoltage0=5Fen to 1, so this clearly wouldn't h=
ave worked with
> > > .channel being 1.
> > > =20
> > > > =20
> > > > > When i run general=5Fbuffer (from the docs dir) with that scan =
element enabled it can no longer read the trigger (Could not open /trigge=
r/current=5Ftrigger =46ailed to write current=5Ftrigger file) - this succ=
eeds if that scan=5Felement is not enabled. =20
> > > > =20
> > > > =20
> > > =20
> > > =20
> > > You can't change the trigger if the buffer is currently enabled. Ma=
ke sure that
> > > he buffer is disabled (check the buffer/enable attribute).
> > > =20
> > > - Lars
> > > u
> > > =20
> > =20
> > =20
> =20
> =20
> =20



--51350602_8edbdab_c85
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div>
                    Jonathan,
                </div><div><br></div><div><span class=3D=22Apple-tab-span=
=22 style=3D=22white-space:pre=22>	</span>Thanks - I'll share back my fin=
dings this week.</div><div><br></div><div><span class=3D=22Apple-tab-span=
=22 style=3D=22white-space:pre=22>	</span>One thing i've run into is thro=
ughput - it seems like the linux spi subsystem has a non-deterministic 50=
-150us delay before an spi=5Fsync or spi=5Fasync command is processed. &n=
bsp;I can't seem to find any way around this - so if i use larger multi-b=
yte transfers using spi=5Fasync and DMA I get great, stable throughput, b=
ut that is broken up by these 50-150us delays between transfers (i'm usin=
g the beagle bone, so AM3359 that has a dedicated SPI controller and DMA.=
) &nbsp;</div><div><br></div><div><span class=3D=22Apple-tab-span=22 styl=
e=3D=22white-space:pre=22>	</span>Have any of you guys had success gettin=
g reliable &gt;1MSPS throughput via IIO over SPI=3F &nbsp;It seems like t=
his inherent delay in the SPI subsystem would make this pretty difficult.=
</div><div><br></div><div>-chris</div><div><br></div>
                <div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On Saturday, March 2, =
2013 at 11:27 AM, Jonathan Cameron wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div>On 02/27/2013 07:32 PM, Chris Mi=
cali wrote:</div><blockquote type=3D=22cite=22><div><div>Guys,  </div><di=
v><br></div><div>Thanks a lot for the help=21  I finally tracked down iss=
ues, it was a combination of a few things:</div><div><br></div><div>1. Th=
e .channel had to be 0, not 1 in the driver (scan=5Findex didn't matter)<=
/div><div>2. 1 or more scan=5Felements have to be enabled as you mentione=
d</div><div>2. When echoing into the sysfs files it has to have a space a=
fter the number (cat 1 &gt; in=5Fvoltage0=5Fen and not cat 1&gt;in=5Fvo=E2=
=80=A6)  (duh=21)</div><div>3. The generic=5Fbuffer.c program had a few b=
ugs in it causing crashes.  I updated the iio=5Futils.h to a newer versio=
n I found here: <a href=3D=22https://github.com/analogdevicesinc/iio-osci=
lloscope=22>https://github.com/analogdevicesinc/iio-oscilloscope</a> and =
then made a few modifications (the newer iio=5Futils did not parse a few =
things right in the channel details like bigendian/littleendian)</div><di=
v><br></div><div>So generic=5Fbuffer is now correctly sampling (although =
it crashes after a couple, it's probably another iio=5Futils issue)</div>=
</div></blockquote><div>If you do track down why this is happening, pleas=
e do report back</div><div>so we can get it fixed.  I wasn't previously a=
ware of any particular</div><div>issues in the example code so any feedba=
ck is helpful=21</div><div><br></div><div>Looking foward to seeing the dr=
iver code when you are happy with it.</div><div><br></div><div>Jonathan</=
div><blockquote type=3D=22cite=22><div><div>Thanks=21=21</div><div><br></=
div><div>-chris</div><div><br></div><div><br></div><div>On Wednesday, =46=
ebruary 27, 2013 at 1:51 PM, Lars-Peter Clausen wrote:</div><div><br></di=
v><blockquote type=3D=22cite=22><div><div>On 02/27/2013 07:28 PM, Jonatha=
n Cameron wrote:</div><blockquote type=3D=22cite=22><div><div>On 02/27/20=
13 05:36 PM, Chris Micali wrote:</div><blockquote type=3D=22cite=22><div>=
<div>lars,  </div><div> </div><div>I was under the impression that flag g=
ets added automatically by iio=5Ftriggered=5Fbuffer=5Fsetup (industrialii=
o-triggers.c:77) - I actually am now able to enable the scan=5Felement af=
ter changing my channel .channel and .scan=5Findex to 0 (trying to match =
exactly the other drivers.)</div></div></blockquote></div></blockquote><d=
iv> </div><div>Yea, you are right I missed the iio=5Ftriggered=5Fbuffer=5F=
setup part.</div><div> </div><blockquote type=3D=22cite=22><div><div>Stra=
nge, scan=5Findex should have defaulted to zero and the .channel value sh=
ouldn't have mattered</div><div>for buffered reads (just effects naming).=
 Might have caused issues with userspace expecting a channel 0</div><div>=
though...</div></div></blockquote><div> </div><div> </div><div> </div><di=
v>I guess the scan=5Findex had nothing to do with this, but I suggested t=
o set</div><div>scan=5Felements/in=5Fvoltage0=5Fen to 1, so this clearly =
wouldn't have worked with</div><div>.channel being 1.</div><div> </div><b=
lockquote type=3D=22cite=22><div><div> </div><blockquote type=3D=22cite=22=
><div>When i run general=5Fbuffer (from the docs dir) with that scan elem=
ent enabled it can no longer read the trigger (Could not open /trigger/cu=
rrent=5Ftrigger =46ailed to write current=5Ftrigger file) - this succeeds=
 if that scan=5Felement is not enabled.  </div></blockquote></div></block=
quote><div> </div><div>You can't change the trigger if the buffer is curr=
ently enabled. Make sure that</div><div>he buffer is disabled (check the =
buffer/enable attribute).</div><div> </div><div>- Lars</div><div>u</div><=
/div></blockquote></div></blockquote></div></div></span>
                =20
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            
--51350602_8edbdab_c85--
